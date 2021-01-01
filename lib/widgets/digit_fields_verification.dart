import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/change_verification_state.dart';
import '../shared/screen_sized.dart';


class DigitalFields extends StatelessWidget {
  final int digits;

  final ValueChanged<String> textChanged;
  final bool isEnabled;
  final List code;
  const DigitalFields({
    Key key,
    @required this.digits,
    this.textChanged,
    this.isEnabled,
    this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.watch<ChangeVerificationState>().status ==
        VerificationState.VERIFIED) {}
    int value = ((SizeConfig.width - getProportionateScreenWidth(32)) / digits -
        (getProportionateScreenWidth(90 - 76.0)))
        .floor();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...List.generate(
          digits,
              (index) {
            return Container(
              width: value.toDouble(),
              height: getProportionateScreenWidth(53.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x0d303030),
                    offset: Offset(0, 5),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Center(
                child: code != null && code[index] != null
                    ? Text(
                  code[index].toString(),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: getProportionateScreenWidth(18),
                    color: const Color(0xffbdbdbd),
                    fontWeight: FontWeight.w700,
                    // height: 1,
                  ),
                )
                    : buildTextField(context, index),
              ),
            );
          },
        )
      ],
    );
  }

  TextField buildTextField(BuildContext context, int index) {
    return TextField(
      enableSuggestions: false,
      enableInteractiveSelection: false,
      toolbarOptions: ToolbarOptions(),
      maxLength: 1,
      textAlign: TextAlign.center,
      enabled: isEnabled,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        counter: SizedBox.shrink(),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: getProportionateScreenWidth(18),
        color: const Color(0xffbdbdbd),
        fontWeight: FontWeight.w700,
        // height: 1,
      ),
      onChanged: (v) {
        try {
          if (v.length == 1) {
            Provider.of<ChangeVerificationState>(context, listen: false)
              ..lastIndex = 6
              ..addDigit(int.parse(v), index);
          }
        } catch (e) {
          print(e);
        }
      },
    );
  }
}
