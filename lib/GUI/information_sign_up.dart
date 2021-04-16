import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:parking_project/models/user_model.dart';
import 'package:parking_project/providers/loading_and_response_provider.dart';
import 'package:parking_project/services/sign_in_app.dart';
import 'package:parking_project/shared/alerts_class.dart';
import 'package:parking_project/shared/handling_auth_error_mixin.dart';
import 'package:provider/provider.dart';
import 'map_home.dart';
import 'package:parking_project/shared/sign_in_project_servies.dart';

class InformationSignUp extends StatefulWidget {
  final User? user;

  const InformationSignUp({Key? key, this.user}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<InformationSignUp> with HandlingAuthErrors, Alerts{
  bool mark2 = true;
  bool mark = true;

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  final LoginServices loginServices = LoginServices();

  final _formKey = GlobalKey<FormState>();


  late SignInServices _signInServices;

  Widget build(BuildContext context) {
    handleException(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            height: height,
            width: width,
            child: Stack(
              children: [
                ClipPath(
                  child: Container(
                      height: 180,
                      width: width,
                      decoration: BoxDecoration(color: Colors.green[500]),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 50.0,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                  Text(
                                    'back',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      )),
                  clipper: MyClipper(),
                ),
                Positioned(
                  top: 70,
                  left: 130,
                  child: CircleAvatar(
                      foregroundColor: Colors.white,
                      child: Stack(
                        alignment: Alignment.topLeft,
                        fit: StackFit.loose,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 70.0,
                          ),
                          Icon(
                            Icons.camera_enhance_outlined,
                            size: 30.0,
                          )
                        ],
                      ),
                      radius: 70.0,
                      backgroundColor: Colors.grey[350]),
                ),
                Container(
                  padding: EdgeInsets.only(top: 210.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 4.0, left: 15.0, right: 15.0),
                        child: TextField(
                          controller: _firstNameController,
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            errorMaxLines: 1,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 4.0, left: 15.0, right: 15.0),
                        child: TextField(
                          controller: _lastNameController,
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            errorMaxLines: 1,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 4.0, left: 15.0, right: 15.0),
                        child: TextField(
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                            labelText: 'Type of vehicle',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            errorMaxLines: 1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          bottom: 4.0,
                        ),
                        child: TextField(
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            hintMaxLines: 1,
                            errorMaxLines: 1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 4.0, left: 15.0, right: 15.0),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: mark2,
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              errorMaxLines: 1,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (mark2 == false) {
                                      mark2 = true;
                                    } else {
                                      mark2 = false;
                                    }
                                  });
                                },
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 4.0, left: 15.0, right: 15.0),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          validator: (val) =>
                              val!.length < 6 ? 'Password too short.' : null,
                          cursorColor: Colors.green,
                          obscureText: mark,
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              errorMaxLines: 1,
                              suffixIcon: InkWell(
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.green,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (mark == false) {
                                        mark = true;
                                      } else {
                                        mark = false;
                                      }
                                    });
                                  })),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () async => _signUp(),
                          child: Card(
                            elevation: 20.0,
                            margin: EdgeInsets.all(8.0),
                            shadowColor: Colors.white70,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Text(
                                    'Create Account',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 120.0,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.grey[400],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
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



  _signUp() async {

    _formKey.currentState!.save();

    if (!_formKey.currentState!.validate()) {
      return;
    }
    Client client = Client(
            id: widget.user!.uid,
            phone: widget.user!.phoneNumber,
            isOwner: false,
            lastName: _lastNameController.text,
            firstName: _firstNameController.text);
    loginServices.signUp(context, client: client, addMap:{'password': _passwordController.text, 'token': await widget.user?.getIdToken()} );
    // context.read<LoadingAndErrorProvider>().changeState(LoadingErrorState.LOADING);
    // Client client = Client(
    //     id: widget.user!.uid,
    //     phone: widget.user!.phoneNumber,
    //     isOwner: false,
    //     lastName: _lastNameController.text,
    //     firstName: _firstNameController.text);
    // String token = '';
    //
    // try {
    //   token = await (_signInServices.signUp(client: client, addMap: {'password': _passwordController.text, 'token': await widget.user?.getIdToken()}));
    // }   catch (e) {
    //   context.read<LoadingAndErrorProvider>()..setError(e.toString().substring(e.toString().indexOf(":") + 2));
    // }
    //
    //
    // if (token.isEmpty) {
    //   context.read<LoadingAndErrorProvider>()
    //     ..changeState(LoadingErrorState.ERROR)
    //     ..setError("un handling token");
    //
    //   return;
    // }
    //
    //
    // _addTokenInHive(token, client);
    //
    // context.read<LoadingAndErrorProvider>().changeState(LoadingErrorState.DONE);
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => MapHome(),
    //     ), (route) => route.isFirst);
  }

  void _addTokenInHive(String token, Client client) async{
    Box userBox = await Hive.openBox('user_data');
    userBox.put('token', token);

    print(token);

    if(client != null) {
      userBox.put('data', client);
    }

    print('DONE ENTER THE TOKEN');

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signInServices = SignInServices();
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 60);
    var controlPoint = Offset(140, size.height);
    var endPoint = Offset(size.width / 2 + 60, size.height - 35);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width + 40, size.height - 125);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
