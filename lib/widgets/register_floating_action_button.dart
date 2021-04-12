import 'package:flutter/material.dart';
import '../shared/screen_sized.dart';
import 'package:parking_project/constant_colors.dart';
class RegFAB extends StatelessWidget {
  const RegFAB({
    Key? key,
    required bool isSuccess, this.onPressed,
  }) : _isSuccess = isSuccess, super(key: key);

  final bool _isSuccess;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(50),
      height: getProportionateScreenWidth(50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getProportionateScreenWidth(25)),
        color: _isSuccess ? kPrimaryColor : const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1a303030),
            offset: Offset(0, 5),
            blurRadius: 15,
          ),
        ],
      ),
      child: FloatingActionButton(
        backgroundColor: _isSuccess ? kPrimaryColor : const Color(0xffffffff),
        onPressed: () => _isSuccess? onPressed!(): null,
        elevation: 0,
        child: Icon(Icons.arrow_forward, color: _isSuccess? Colors.white:kBollColorBD),
      ),
    );
  }
}
