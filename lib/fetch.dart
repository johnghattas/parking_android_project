import 'dart:convert';
import 'package:parking_project/models/comments.dart';
import 'package:parking_project/models/floors_model.dart';
import 'package:parking_project/models/garage_model.dart';
import 'package:http/http.dart' as http;

class FetchApi {
  // add data of the owner
  Future<bool> addComment(FloorsModel floorsModel, String token) async {
    String url = 'https://parkingprojectgp.herokuapp.com/api/comments/add/';
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          'Accept': "application/json",
          "Authorization": "Bearer $token"
        },
        body: floorsModel.toMap());
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

  Future<bool> addData(Model model, String token) async {
    String url = 'https://parkingprojectgp.herokuapp.com/api/garages';
    print(json.encode(model.toMap()));
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(model.toMap()),
          // 'floorList', jsonEncode(model.floor?.map((e) => e.toMap()).toList())
        );

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

  Future<List<Comments>> getComments(int id, String token) async {
    print(id);
    String url = 'https://parkingprojectgp.herokuapp.com/api/commentindex/$id';
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Accept': 'Application/json',
      'Authorization': "Bearer $token"
    });
    print('response status: ${response.body}');
    List body = jsonDecode(response.body);
    print(body);
    if (response.statusCode == 200) {
      return body.map((e) => Comments.fromMap(e)).toList();
    }
    return [];
  }

  //get data from api
  Future<List<Model>> getData(String token) async {
    String url = 'https://parkingprojectgp.herokuapp.com/api/owner/garages';
    http.Response response = await http.get(
        Uri.parse(
          url,
        ),
        headers: {
          'Accept': 'Application/json',
          'Authorization': 'Bearer $token'
        });
    print('response status:${response.body}');
    Map body = jsonDecode(response.body);
    print(body['data']);
    if (response.statusCode == 200) {
      List list = body['data'];
      print('code here');

      return list.map((e) => Model.fromMap(e)).toList();
    }

    return [];
  }

  Future<bool> editData(Model model, String token, int id) async {
    String url = 'https://parkingprojectgp.herokuapp.com/api/garages/$id';
    http.Response response = await http.put(Uri.parse(url),
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
}
//
// class Test extends StatelessWidget {
//   final FetchApi fetchApi = FetchApi();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('d'),
//       ),
//       body: ElevatedButton(
//         onPressed: () {
//           // return fetchApi.addData;
//         },
//         child: Text('a'),
//       ),
//     );
//   }
// }
