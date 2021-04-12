import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_number/phone_number.dart';
import 'package:parking_project/shared/country_field_validate.dart';
import '../customs/phone_format.dart';
import '../shared/screen_sized.dart';

import '../constant_colors.dart';

class PhoneNumberField extends StatefulWidget {
  final ValueChanged<CountryCode>? onCodeChanged;
  final ValueChanged<String>? onPhoneChanged;

  const PhoneNumberField({Key? key, this.onCodeChanged, this.onPhoneChanged}) : super(key: key);
  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {



  // String _countryCode = 'EG';
  bool _isValid = false;

  late FieldPhoneValidate _fieldPhoneValidate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fieldPhoneValidate = FieldPhoneValidate('EG');

  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: Key('login_phone'),

      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 0),
        suffixIcon: _isValid
            ? Icon(CupertinoIcons.check_mark_circled_solid)
            : null,
        prefix: CountryCodePicker(
          textStyle: TextStyle(
            fontFamily: "Poppins",
            fontSize: 18,
            color: Color(0xff24272b),
          ),
          initialSelection: "EG",
          onChanged: (CountryCode value) {
            widget.onCodeChanged!(value);
            _fieldPhoneValidate.countryCode = value.code;
            setState(() {
              _isValid = false;
            });
            print(_fieldPhoneValidate.countryCode);
          },
          padding:
          const EdgeInsets.only(right: 12, bottom: 0),
        ),

        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: getProportionateScreenWidth(14),
          color: kHintText79,
          height: 1.3,
        ),
        labelText: 'Phone number',
      ),
      keyboardType: TextInputType.phone,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 18,
        color: Color(0xff24272b).withOpacity(0.80),
      ),
      inputFormatters: [PhoneFormatter(10)],
      onChanged: (value) async {
        widget.onPhoneChanged!(value);

        if ( await _fieldPhoneValidate.correctField(
            value.replaceAll(' ', ''))) {
          print('here');

          setState(() {
            _isValid = true;
          });
        } else
          setState(() {
            _isValid = false;
          });
      },
    );
  }

}
