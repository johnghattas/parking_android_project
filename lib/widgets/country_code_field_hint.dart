import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import '../customs/phone_format.dart';

import '../constant_colors.dart';


class CountryCodeFieldHint extends StatelessWidget {
  CountryCodeFieldHint({
    Key key,
    this.onChange,
    this.initialCode = 'EG',
    this.onTap,
    this.focusNode, this.onChangedCountry,
  }) : super(key: key);

  final ValueChanged<String> onChange;
  final String initialCode;
  final Function() onTap;
  final FocusNode focusNode;
  final ValueChanged<CountryCode> onChangedCountry;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
            color: kTextColor30.withOpacity(0.1),
            offset: Offset(0, 5),
            blurRadius: 15,
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            height: 65,
            child: CountryCodePicker(
              onChanged: onChangedCountry,
              initialSelection: initialCode,
              flagWidth: 23,
              dialogTextStyle: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14,
                color: const Color(0xff24272b),
              ),
            ),
          ),
          VerticalDivider(),
          Expanded(
            child: TextField(
              focusNode: focusNode,
              onTap: onTap,
              autofocus: true,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Enter your phone number',
                hintStyle: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  color: Color(0xff303030),
                ),
              ),
              keyboardType: TextInputType.phone,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 18,
                color: Color(0xff24272b).withOpacity(0.80),
              ),
              inputFormatters: [PhoneFormatter(10)],
              onChanged: onChange,
            ),
          ),
        ],
      ),
    );
  }
}
