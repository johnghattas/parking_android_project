import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class InformationSignUp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<InformationSignUp> {
  bool mark2 = true;
  bool mark = true;

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
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
                            onTap: (){
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
                        validator: (val) =>
                            val.length < 6 ? 'Password too short.' : null,
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
