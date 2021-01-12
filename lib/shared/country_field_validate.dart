import 'package:phone_number/phone_number.dart';

class FieldPhoneValidate{
  PhoneNumberUtil phoneUtil = PhoneNumberUtil();
  String countryCode = 'EG';

  FieldPhoneValidate(this.countryCode){
    phoneUtil = PhoneNumberUtil();
  }

  Future<bool> correctField(String value) async {
    bool isValid = false;

    try {
      isValid = await phoneUtil.validate(value, this.countryCode);
    } catch (e) {
      // PhoneFormatter.isEndValue = true;
      print(e);
    }
    print(isValid);

    return isValid;
  }
}