import 'package:flutter/material.dart';
import 'package:parking_project/constant_colors.dart';
import '../shared/screen_sized.dart';

class PhoneTextValidation extends StatelessWidget {
  const PhoneTextValidation({
    Key? key,
    required this.phone,
    this.code,
  }) : super(key: key);

  final String? phone;
  final String? code;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: getProportionateScreenWidth(12),
              color: kTextColor30,
              height: 1.1666666666666667,
            ),
            children: [
              TextSpan(
                text: 'Phone Verification\n',
              ),
              TextSpan(
                text: 'Enter your OTP code',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(24),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: getProportionateScreenWidth(14),
              color: kTextColor30,
              height: 1.5714285714285714,
            ),
            children: [
              TextSpan(
                text:
                'Enter the 6-digit code sent to you at\n${this.code}${this.phone}.',
              ),
              TextSpan(
                text: ' ',
                style: TextStyle(
                  color: const Color(0xff353b50),
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextSpan(
                text: 'did you enter the correct \nnumber?',
                style: TextStyle(
                  color: const Color(0xff58be3f),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}