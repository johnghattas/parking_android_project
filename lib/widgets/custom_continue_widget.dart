
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parking_project/providers/change_verification_state.dart';
import '../shared/screen_sized.dart';

import '../constant_colors.dart';

class CustomContinueButton extends StatelessWidget {
  const CustomContinueButton({
    Key? key,
    this.title,
    this.onPressed,
    this.isEnable = false,
  }) : super(key: key);
  final String? title;
  final Function? onPressed;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return Provider<ChangeVerificationState>(

      create:(context) => ChangeVerificationState(),
      child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isEnable ? kPrimaryColor : Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                color: kTextColor30.withOpacity(0.1),
                offset: Offset(0, 5),
                blurRadius: 15,
              ),
            ],
          ),
          child: MaterialButton(
            height: getProportionateScreenWidth(55),
            onPressed: onPressed == null || !isEnable? null : () => onPressed!(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title ?? '',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: getProportionateScreenWidth(14),
                      color: isEnable ? Colors.white : kBollColorBD,
                      fontWeight: FontWeight.w500,
                      height: 1.7,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: isEnable ? Colors.white : kBollColorBD,
                    size: getProportionateScreenWidth(24),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
