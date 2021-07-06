import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parking_project/garage_model.dart';
import 'package:http/http.dart' as http;

class FetchApi {
  // add data of the owner
  Future<bool> addData(Model model, String token) async {
    String url = 'https://parkingprojectgp.herokuapp.com/api/garages';
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: model.toMap());

    print('response status: ${response.statusCode}');
      Map? body = jsonDecode(response.body);
      print(body);

    if (response.statusCode == 200) {
      if (body!.containsKey('success')) {
        return true;
      }
    }
    if (response.statusCode == 401) {
       throw Exception('Un Authorization');

    }
    return false;
  }
  //get data from api
  Future <List<Model>>getData(String token)async{
    String url='https://parkingprojectgp.herokuapp.com/api/owner/garages';
    http.Response response = await http.get(Uri.parse(url,),headers:
        {
        'Accept': 'Application/json',
          'Authorization': 'Bearer $token'
        });
    print('response status:${response.body}');
    Map body = jsonDecode(response.body);
    print(body['data']);
    if(response.statusCode == 200) {
      List list = body['data'];
      print('code here');

      return list.map((e) => Model.fromMap(e)).toList();
    }

    return [];

  }
}

class Test extends StatelessWidget {
  final FetchApi fetchApi = FetchApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('d'),
      ),
      body: ElevatedButton(
        onPressed: () {
          // return fetchApi.addData;
        },
        child: Text('a'),
      ),
    );
  }
}
