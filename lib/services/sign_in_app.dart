import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parking_project/const_data.dart';
import 'package:parking_project/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:parking_project/providers/loading_and_response_provider.dart';

abstract class AuthServices {
  Future signIn({
   @required String phone,
   @required String password,
   @required bool isOwner,
  });

  Future signOut(String token) ;

  Future signUp({
    @required Client client,

  });
}

class SignInServices extends AuthServices{

  http.Client _client;
  BuildContext _context;

  SignInServices(this._context) {
    _client = http.Client();
  }

  SignInServices.test(client) {
    this._client = client;

  }

  @override
  Future<String> signIn({String phone, String password, bool isOwner}) async{
    assert(phone != null && phone.isNotEmpty);
    assert(password != null && password.isNotEmpty);
    assert(isOwner != null);

    http.Response response = await _client.post('$cUrl/auth/login', body:{
      'phone': phone,
      'password': password,
    },headers: {
      'accept': 'application/json'
    });


    Map map=_checkResponse(response);
    if ( map  != null) {

      return map['access_token'].toString();
    }


    return '';


  }


  @override
  Future signOut(String token) async{
    assert(token != null && token.isNotEmpty);

    http.Response response = await http.post('$cUrl/auth/logout', headers: {
      'Authorization': token
    },);

    Map map = _checkResponse(response);

    if (map != null && map['message'] == 'Successfully logged out') {

      return map['message'];
    }

    return null;
  }


  @override
  Future signUp({Client client}) async{

    client.checkAsserts();

    http.Response response = await _client.post('$cUrl/register', body: client.toMap(),
    headers: {
      'accept': 'application/json'
    });

    Map map = _checkResponse(response);

    if (map != null) {

      return map['access_token'].toString();
    }

    return null;
  }

  Map _checkResponse(http.Response response) {
    if(response.statusCode == 401) {
      print('un auth');
      _context.read<LoadingAndErrorProvider>().setError("un authentication");


      return null;
    }

    Map map = jsonDecode(response.body);
    print(map);


    if(map.containsKey('access_token')) {

    }

    return map;
  }


}
