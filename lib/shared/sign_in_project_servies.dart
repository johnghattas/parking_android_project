
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:parking_project/GUI/map_home.dart';
import 'package:parking_project/GUI/owner_home_page.dart';
import 'package:parking_project/models/user_model.dart';
import 'package:parking_project/providers/change_verification_state.dart';
import 'package:parking_project/providers/loading_and_response_provider.dart';
import 'package:parking_project/services/sign_in_app.dart';
import 'package:provider/provider.dart';

import 'alerts_class.dart';
import 'handling_auth_error_mixin.dart';

abstract class SignInParameter{
  String? email;
  String? phone;
  String? firstName;
  String? lastName;
  String? name;
  late String password;
  late String isOwner;

  toSignInMap(){
    Map map = {'password': password};
    if(email == null&& phone != null){
      map['phone'] = phone;
    }else
      map['email'] = email;

    return map;
  }

  toSignUpMap(){
    Map map = {'password': password};

    if(name == null && (firstName != null && lastName != null)) {
      map.addAll({
        'first_name' : firstName,
        'last_name' : lastName,
      });
    }else
      map['name'] = name;

    if(email == null&& phone != null){
      map['phone'] = phone;
    }else
      map['email'] = email;

    return map;
  }


}

class LoginServices extends HandlingAuthErrors with Alerts{
  final SignInServices signInServices = SignInServices();

  logIn(BuildContext context, {
    required String? phone,
    required String? password,
    required bool isOwner,
  }) async {
    String token;

    context
        .read<LoadingAndErrorProvider>()
        .changeState(LoadingErrorState.LOADING);
    try {
      var time = DateTime.now();
      print(phone??'fady' + ' cxcazsca '+(password??'fady'));

      token = await signInServices.signIn(
          phone: phone!, password: password!, isOwner: isOwner);

      print('the time of this sequense is ${DateTime.now().difference(time)}');
    } on Exception catch (e) {
      context.read<LoadingAndErrorProvider>()
        ..changeState(LoadingErrorState.ERROR)
        ..setError(e.toString());
      print(e);
      return;
    }

    if (token.isEmpty) {
      context.read<LoadingAndErrorProvider>()
        ..changeState(LoadingErrorState.ERROR)
        ..setError("un handling token");

      return;
    }

    print(token.isEmpty);

    context
        .read<LoadingAndErrorProvider>()
        .changeState(LoadingErrorState.DONE);

    _putTokenAndPush(context, token);
  }

  signUp(BuildContext context, {
    required Client client,
    required Map addMap
  }) async {

    String token = '';

    context
        .read<LoadingAndErrorProvider>()
        .changeState(LoadingErrorState.LOADING);

    try {
      token = await signInServices.signUp(client: client, addMap: addMap);
    } catch (e) {
      context.read<LoadingAndErrorProvider>()
        ..changeState(LoadingErrorState.ERROR)
        ..setError(e.toString());
      throw e;
    }

    if (token.isEmpty) {
      context.read<LoadingAndErrorProvider>()
        ..changeState(LoadingErrorState.ERROR)
        ..setError("un handling token");
      return;
    }
    context
        .read<LoadingAndErrorProvider>()
        .changeState(LoadingErrorState.DONE);
    _putTokenAndPush(context, token);
  }

  Future<Client?> _addTokenInHive(String token) async {
    Box userBox = Hive.box('user_data');
    userBox.put('token', token);

    print('token is --------' + userBox.get('token'));
    Client? user = await signInServices.getUser(token);

    if (user != null) {
      userBox.put('data', user);
      print('user is --------' + userBox.get('data').name);
    }

    print('DONE ENTER THE TOKEN');
    return user;
  }

  void _putTokenAndPush(BuildContext context, String token) async{
    Client? user = await _addTokenInHive(token);
    context.read<LoadingAndErrorProvider>().changeState(LoadingErrorState.DONE);

    if (user == null) {
      return;
    }
    if (user.isOwner! && context.read<ChangeVerificationState>().isAdmin!) {
      //to Admin page
      Navigator.pushNamedAndRemoveUntil(
          context, OwnerHomePage.NAME, (router) => !router.navigator!.canPop());
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, MapHome.NAME, (router) => !router.navigator!.canPop());
    }
  }
}
