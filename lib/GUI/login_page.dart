import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:parking_project/GUI/owner_home_page.dart';
import 'package:parking_project/block/garage_bloc.dart';
import 'package:parking_project/providers/change_verification_state.dart';
import 'package:parking_project/repositers/parking_repo.dart';
import 'package:parking_project/services/sign_in_app.dart';
import 'package:parking_project/shared/alerts_class.dart';
import 'package:parking_project/shared/constant_widget.dart';
import 'package:parking_project/shared/handling_auth_error_mixin.dart';
import 'package:parking_project/widgets/custom_button.dart';
import 'package:parking_project/widgets/phone_number.dart';
import 'package:provider/provider.dart';

import '../constant_colors.dart';
import '../models/user_model.dart';
import '../shared/screen_sized.dart';
import '../widgets/text_custom_paint.dart';
import 'map_home.dart';
import 'regester_page_index.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with HandlingAuthErrors, Alerts {
  late SignInServices _signInServices;

  var _passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _code = '+20';

  late String _phone;

  bool isLoadingShow = false;

  @override
  Widget build(BuildContext context) {
    handleException(context);
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: ConstantWidget.appBarGreen as PreferredSizeWidget?,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: SizeConfig.height,
            width: SizeConfig.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: getProportionateScreenWidth(240),
                        width: SizeConfig.width,
                        child: TextAndCustomPaint(),
                      ),
                      Positioned(
                        bottom: -10,
                        right: 0,
                        left: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              onChanged: (value) => context
                                  .read<ChangeVerificationState>()
                                  .changeAdmin(value),
                              value: context
                                  .watch<ChangeVerificationState>()
                                  .isAdmin,
                            ),
                            Text(
                              'Sign in like owner',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  letterSpacing: 0.65),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  VerticalSpacing(of: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back!',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: getProportionateScreenWidth(26),
                            color: const Color(0xff303030),
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        VerticalSpacing(of: 20),
                        PhoneNumberField(
                          onCodeChanged: (code) => _code = code.dialCode,
                          onPhoneChanged: (phone) => _phone = phone,
                        ),
                        VerticalSpacing(of: 20),
                        TextField(
                            key: Key('login_password'),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: getProportionateScreenWidth(14),
                                color: kHintText79,
                                height: 1.3,
                              ),
                              labelText: 'Password',
                            ),
                            controller: _passwordController,
                            obscureText: true,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 18,
                            )),
                        VerticalSpacing(of: 10),
                        Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: getProportionateScreenWidth(14),
                            color: kTextColor30,
                            height: 2.9,
                          ),
                          // textAlign: TextAlign.right,
                        ),
                        VerticalSpacing(of: 30),
                        Hero(
                          tag: "heroButtonLogin",
                          child: CustomButtonIcon(
                            title: "Login",
                            key: Key('login_button'),
                            onPressed: () async => await _logIn(),
                          ),
                        ),
                        VerticalSpacing(of: 40),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegisterIndex()));
                          },
                          child: Text(
                            "Or Create My Account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w300,
                              fontSize: getProportionateScreenWidth(14),
                              color: kBlackLight50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _signInServices = SignInServices(context);
  }

  Future<Client?> _addTokenInHive(String token) async {
    Box userBox = await Hive.openBox('user_data');
    userBox.put('token', token);

    print(token);
    Client? client = await (_signInServices.getUser(token));

    if (client != null) {
      userBox.put('data', client);
    }

    print('DONE ENTER THE TOKEN');
    return client;
  }

  _logIn() async {
    String token;

    print(_code! + _phone.replaceAll(' ', ''));

    try {
      var time = DateTime.now();

      token = await _signInServices.signIn(
          phone: _code! + _phone.replaceAll(' ', ''),
          password: _passwordController.text,
          isOwner: true);

      print('the time of this sequense is ${DateTime.now().difference(time)}');
    } catch (e) {
      print('this is ' + e.toString());
      return;
    }

    if (token == null || token.isEmpty) {
      return null;
    }

    print(token.isEmpty);

    Client? client = await (_addTokenInHive(token));
    if (isLoadingShow) {
      Navigator.pop(context);
      isLoadingShow = false;
    }
    if (client == null) {
      print('is null');
      return;
    }

    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => MapHome(),
    //     ),
    //     (route) => !route.navigator.canPop());
    if (client.isOwner! && context.read<ChangeVerificationState>().isAdmin!) {
      //to Admin page
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OwnerHomePage(),
          ),
          (router) => router.isFirst);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) =>
                    GarageBloc(ParkingRepo())..add(GetDataEvent()),
                child: MapHome()),
          ),
          (router) => router.isFirst);
    }
  }
}
