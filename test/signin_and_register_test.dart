import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:parking_project/const_data.dart';
import 'package:parking_project/models/user_model.dart';
import 'package:parking_project/services/sign_in_app.dart';

class MocHttpClient extends Mock implements http.Client {}

main() {
  group('feature test', () {
    test('sign in test', () async {
      final mocClient = MocHttpClient();
      final signInServices = SignInServices.test(mocClient);

      when(mocClient.post('$cUrl/auth/login', body: {
        'phone': '01202',
        'password': '012',
      })).thenAnswer((realInvocation) => Future.value(
          http.Response(jsonEncode({'access_token': 'token'}), 200)));

      expect(
          await signInServices.signIn(
              phone: '01202', password: '012', isOwner: true),
          'token');
    });
    test('sign in error un authorize', () async {
      final mocClient = MocHttpClient();
      final signInServices = SignInServices.test(mocClient);

      when(mocClient.post('$cUrl/auth/login', body: {
        'phone': '01202',
        'password': '012',
      })).thenAnswer((realInvocation) => Future.value(
          http.Response(jsonEncode({'access_token': 'token'}), 401)));

      expect(
          await signInServices.signIn(
              phone: '01202', password: '012', isOwner: true),
          null);
    });

    test('sign in validation', () async {
      final mocClient = MocHttpClient();
      final signInServices = SignInServices.test(mocClient);

      when(mocClient.post('$cUrl/auth/login', body: {
        'phone': '',
        'password': '012',
      })).thenAnswer((realInvocation) =>
          Future.value(http.Response(jsonEncode({'phone': 'token'}), 200)));

      expect(
          () =>
              signInServices.signIn(phone: '', password: '012', isOwner: true),
          throwsAssertionError);
    });
    test('sign up validation', () async {
      final mocClient = MocHttpClient();
      final signInServices = SignInServices.test(mocClient);

      Client client = Client.fromMap({
        'id': 'testid',
        'last_name': 'ghattas',
        'first_name': 'john',
        'phone': '01202488740',
        'is_owner': 1
      });

      when(mocClient.post('$cUrl/register',
              body: client.toMap(), headers: {'accept': 'application/json'}))
          .thenAnswer((realInvocation) => Future.value(
              http.Response(jsonEncode({'access_token': 'token'}), 200)));

      expect(await signInServices.signUp(client: client), 'token');
    });
    test('sign up validation when empty', () async {
      final mocClient = MocHttpClient();
      final signInServices = SignInServices.test(mocClient);

      Client client = Client.fromMap({
        'id': '',
        'last_name': '',
        'first_name': '',
        'phone': '',
        'is_owner': 1
      });

      when(mocClient.post('$cUrl/register',
              body: client.toMap(), headers: {'accept': 'application/json'}))
          .thenAnswer((realInvocation) => Future.value(
              http.Response(jsonEncode({'access_token': 'token'}), 200)));

      expect(signInServices.signUp(client: client), throwsAssertionError);
    });
  });

  group('unit test for Auth', () {
    test('test client model', () async {
      Client client = Client.fromMap({
        'id': 'testid',
        'last_name': 'ghattas',
        'first_name': 'john',
        'phone': '01202488740',
        'is_owner': 1
      });

      expect(client.id, 'testid');
      expect(client.lastName, 'ghattas');
      expect(client.firstName, 'john');
      expect(client.phone, '01202488740');
      expect(client.isOwner, true);
      expect(client.name, 'john ghattas');
      expect(client.toMap(), {
        'id': 'testid',
        'last_name': 'ghattas',
        'first_name': 'john',
        'phone': '01202488740',
        'is_owner': 1
      });
    });
  });
}
