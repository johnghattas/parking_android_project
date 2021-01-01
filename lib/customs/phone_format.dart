import 'package:flutter/services.dart';

class PhoneFormatter extends TextInputFormatter {
  int finalLength;

  PhoneFormatter(this.finalLength);

  // static Stream<bool> isEndValue = false as Stream<bool>;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int newLength = newValue.selection.end;
    int oldLength = oldValue.selection.end;

    StringBuffer stringBuffer = StringBuffer();

    int lengthWithoutSpacing = newValue.text.replaceAll(' ', '').length;

    if (finalLength < lengthWithoutSpacing) {
      // isEndValue = true as Stream<bool>;
      stringBuffer.write(oldValue.text);
    } else if (newLength % 4 == 3) {
      // isEndValue = false as Stream<bool>;
      stringBuffer.write(oldValue.text +
          " " +
          newValue.text.substring(oldLength, newValue.selection.end));
    } else {
      // isEndValue = false as Stream<bool>;
      stringBuffer.write(newValue.text);
    }

    return TextEditingValue(
        text: stringBuffer.toString(),
        selection: TextSelection.collapsed(offset: stringBuffer.length));
  }
}