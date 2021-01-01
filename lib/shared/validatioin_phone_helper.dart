import 'package:flutter/material.dart';
import 'package:parking_project/shared/country_field_validate.dart';
import 'package:parking_project/shared/screen_sized.dart';

import '../constant_colors.dart';

Future<bool> checkNumberFromCode(String value, FieldPhoneValidate fieldPhoneValidate, ScrollController scrollController) async {
  if (await fieldPhoneValidate.correctField(value.replaceAll(' ', ''))) {
    print('here');

    scrollToBottom(scrollController);
    return true;
  } else
    return false;
}

Text joinOurCompanyText() {
  return Text.rich(
    TextSpan(
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: getProportionateScreenWidth(12),
        color: kTextColor30,
        height: 1.17,
      ),
      children: [
        TextSpan(
          text: 'Hello, nice to meet you!\n',
        ),
        TextSpan(
          text: 'Join our Company!',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(24),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
    // textAlign: TextAlign.left,
  );
}

Text privacyTextWidget() {
  return Text.rich(
    TextSpan(
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: getProportionateScreenWidth(12),
        color: kTextColor30,
      ),
      children: [
        TextSpan(
          text: 'By creating an account, you agree to our \n',
        ),
        TextSpan(
          text: 'Terms of Service',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        TextSpan(
          text: ' and ',
        ),
        TextSpan(
          text: 'Privacy Policy',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
    textAlign: TextAlign.left,
  );
}

Future<void> scrollToBottom(ScrollController scrollController) {
  return scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn);
}