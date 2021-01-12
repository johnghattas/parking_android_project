import 'package:flutter/material.dart';
import 'package:parking_project/shared/screen_sized.dart';

import '../constant_colors.dart';

class CustomButtonIcon extends StatelessWidget {
  const CustomButtonIcon({
    Key key, this.title, this.icon, this.onPressed,
  }) : super(key: key);

  final String title;
  final Icon icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      child: RaisedButton(
        onPressed: () => onPressed(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title?? "", style: TextStyle(
                fontFamily: "Poppins",fontWeight: FontWeight.w600,
                fontSize: getProportionateScreenWidth(14),
                color: Colors.white,
              ),),
              icon?? Icon(Icons.arrow_forward, color: Colors.white, size: getProportionateScreenWidth(24),),
            ],
          ),
        ),

        color: kPrimaryColor,
      ),
    );
  }
}