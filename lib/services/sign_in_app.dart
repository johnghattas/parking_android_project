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
    required Map addMap

  });
}

class SignInServices extends AuthServices{

  late http.Client _client;

  SignInServices() {
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


    // _context!.read<LoadingAndErrorProvider>().changeState(LoadingErrorState.LOADING);

    http.Response response = await _client.post(Uri.parse( '$cUrl/auth/login'), body:{
      'phone': phone,
      'password': password,
      'is_owner' : isOwner? '1' : '0'
    },headers: {
      'accept': 'application/json'
    });

    // _context!.read<LoadingAndErrorProvider>().changeState(LoadingErrorState.NONE);

    Map? map;
    try {
      map=_checkResponse(response);
    } catch (e) {
      throw e;
    }
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
  Future<String> signUp({required Client client, required Map addMap}) async{

    print(addMap);
    // client.checkAsserts();
    // _context!.read<LoadingAndErrorProvider>().changeState(LoadingErrorState.LOADING);

    http.Response response = await http.post(Uri.parse('$cUrl/register'), body: {...client.toMap(), ...addMap},
    headers: {
      'accept': 'application/json'
    });
    print('code herer' + response.body);

    // _context!.read<LoadingAndErrorProvider>().changeState(LoadingErrorState.NONE);

      Map map;
    try {
      map = _checkResponse(response)!;
    } catch (e) {
      print('this error -----------');

      throw e;
    }
    print('this is the map'+map.toString());


    if(map.containsKey('message') && map['message'] == 'Server Error') {
      // _context!.read<LoadingAndErrorProvider>().setError("The phone is already existed");
      throw Exception('The phone is already existed');
    }

    return map['token'];
  }

  Map? _checkResponse(http.Response response) {
    if (response.statusCode == 401) {
      print('un auth');
      throw Exception('un authentication');
    }

    Map map = jsonDecode(response.body);
    print(map);

    if(response.statusCode == 400){
      throw Exception(map['error']);
    }
    if (map.containsKey('access_token')) {
      // _context.read<LoadingAndErrorProvider>().changeState(LoadingErrorState.DONE);

    }else if (map.containsKey('token')) {

    }

    return map;
  }




}
