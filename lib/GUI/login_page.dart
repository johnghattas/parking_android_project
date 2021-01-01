import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parking_project/GUI/mp_home.dart';
import 'package:parking_project/GUI/owner_home_page.dart';
import 'package:parking_project/providers/loading_and_response_provider.dart';
import 'package:parking_project/services/sign_in_app.dart';
import 'package:parking_project/shared/constant_widget.dart';
import 'package:parking_project/widgets/custom_button.dart';
import 'package:parking_project/widgets/phone_number.dart';

import '../constant_colors.dart';
import '../shared/screen_sized.dart';
import '../widgets/text_custom_paint.dart';
import 'regester_page_index.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SignInServices _signInServices;

  var _passwordController = TextEditingController();

  String _code = '+20';

  String _phone;

  bool _isShow = false;

  @override
  void initState() {
    super.initState();

    _signInServices = SignInServices(context);
  }

  @override
  Widget build(BuildContext context) {
    handleException();
    SizeConfig().init(context);

    return Scaffold(
      appBar: ConstantWidget.appBarGreen,
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
                _isShow
                    ? Stack(
                        children: [
                          Container(
                            height: getProportionateScreenWidth(240),
                            width: SizeConfig.width,
                            child: TextAndCustomPaint(),
                          ),

                          Positioned(
                            bottom: 0,
                            right: 200,
                            child: Row(
                              children: [
                                Icon(Icons.auto_awesome),
                                Text(context.watch<LoadingAndErrorProvider>().error?? ""),
                              ],
                            ),
                          )
                        ],
                      )
                    : Container(
                        height: getProportionateScreenWidth(240),
                        width: SizeConfig.width,
                        child: TextAndCustomPaint(),
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
    );
  }

  handleException() async {
    var watch = context.watch<LoadingAndErrorProvider>();

    print(watch.error);

    if (watch.error != null && !_isShow) {
      setState(() {
        _isShow = true;
      });
       Future.delayed(Duration(seconds: 1),(){
        watch.reset();

        // _isShow = false;
      });

    } else if (watch.state == LoadingErrorState.NONE) {

    }

  }

  _logIn() async {
    String token;

    print(_code + _phone.replaceAll(' ', ''));

    try {
      token = await _signInServices.signIn(
          phone: _code + _phone.replaceAll(' ', ''),
          password: _passwordController.text,
          isOwner: true);
    } catch (e) {
      print(e);
      return;
    }

    if (token == null || token.isEmpty) {
      return null;
    }

    print(token.isEmpty);

    _addTokenInHive();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MapHome(),
        ),
        (route) => !route.navigator.canPop());
  }

  void _addTokenInHive() {}
}
