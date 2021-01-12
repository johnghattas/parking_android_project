import 'package:flutter/material.dart';

import '../constant_colors.dart';

class ConstantWidget {
  static Widget appBarGreen = PreferredSize(
    preferredSize: Size.fromHeight(0),
    child: AppBar(
      backgroundColor: kPrimaryColor,
      brightness: Brightness.dark,
      elevation: 0.0,
    ),
  );

  static Widget appBarWhite = PreferredSize(
    preferredSize: Size.fromHeight(0),
    child: AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      elevation: 0.0,
    ),
  );
}