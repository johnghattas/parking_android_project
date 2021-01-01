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
}