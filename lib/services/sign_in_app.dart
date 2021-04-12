import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parking_project/const_data.dart';
import 'package:parking_project/models/user_model.dart';
import 'package:parking_project/providers/loading_and_response_provider.dart';
import 'package:provider/provider.dart';

abstract class AuthServices {
  Future getUser(String token);

  Future signIn({
   required String phone,
   required String password,
   required bool isOwner,
  });

  Future signOut(String token) ;

  Future signUp({
    required Client client,
    required Map passwordMap

  });
}

class SignInServices extends AuthServices{

  late http.Client _client;
  BuildContext? _context;

  SignInServices(this._context) {
    _client = http.Client();
  }

  SignInServices.test(client) {
    this._client = client;

  }

  @override
  Future<Client?> getUser(String token) async{
    print('token' + token);

    http.Response response = await _client.post(Uri.parse('$cUrl/auth/me'),headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer $token'

    });

    Map? map=_checkResponse(response);
    print('get user map is'+ map.toString());

    if ( map  != null) {

      return Client.fromMap(map);
    }

    return null;
  }


  @override
  Future<String> signIn({String? phone, String? password, required bool isOwner}) async{
    assert(phone != null && phone.isNotEmpty);
    assert(password != null && password.isNotEmpty);


    _context!.read<LoadingAndErrorProvider>().changeState(LoadingErrorState.LOADING);

    http.Response response = await _client.post(Uri.parse( '$cUrl/auth/login'), body:{
      'phone': phone,
      'password': password,
    },headers: {
      'accept': 'application/json'
    });

    _context!.read<LoadingAndErrorProvider>().changeState(LoadingErrorState.NONE);

    Map? map=_checkResponse(response);
    print(map);

    if ( map  != null) {

      return map['access_token'].toString();
    }else{
      // _context.read<LoadingAndErrorProvider>().setError(null);

    }


    return '';


  }


  @override
  Future signOut(String token) async{
    assert( token.isNotEmpty);

    http.Response response = await http.post(Uri(path:'$cUrl/auth/logout'), headers: {
      'Authorization': 'Bearer $token'
    },);

    Map? map = _checkResponse(response);

    if (map != null && map['message'] == 'Successfully logged out') {

      return map['message'];
    }

    return null;
  }

  @override
  Future signUp({required Client client, required Map passwordMap}) async{

    client.checkAsserts();
    _context!.read<LoadingAndErrorProvider>().changeState(LoadingErrorState.LOADING);

    http.Response response = await _client.post(Uri(path:'$cUrl/register'), body: client.toMap()..addAll(passwordMap),
    headers: {
      'accept': 'application/json'
    });
    _context!.read<LoadingAndErrorProvider>().changeState(LoadingErrorState.NONE);

    Map? map = _checkResponse(response)!;
    print(map);


    if(map.containsKey('message') && map['message'] == 'Server Error') {
      _context!.read<LoadingAndErrorProvider>().setError("The phone is already existed");

    }if (map != null) {

      return map['token'];
    }

    return null;
  }

  Map? _checkResponse(http.Response response) {
    if(response.statusCode == 401) {
      print('un auth');
      _context!.read<LoadingAndErrorProvider>().setError("un authentication");
      return null;
    }

    Map map = jsonDecode(response.body);
    print(map);


    if(map.containsKey('access_token')) {
      _context!.read<LoadingAndErrorProvider>().changeState(LoadingErrorState.DONE);

    }if(map.containsKey('token')) {
      _context!.read<LoadingAndErrorProvider>().changeState(LoadingErrorState.DONE);

    }

    return map;
  }




}
