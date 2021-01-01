import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parking_project/GUI/informatio_sign_up.dart';

import '../block/keyboard_change.dart';
import '../providers/change_verification_state.dart';
import '../services/phone_verification.dart';
import '../shared/constant_widget.dart';
import '../shared/screen_sized.dart';
import '../widgets/digit_fields_verification.dart';
import '../widgets/phone_text_validation.dart';
import '../widgets/register_floating_action_button.dart';
import '../widgets/text_custom_paint.dart';
import '../widgets/text_with_keyboard_animation.dart';

class OPTPage extends StatefulWidget {
  final String phone;

  final String code;

  const OPTPage({Key key, this.phone, this.code}) : super(key: key);

  @override
  _OPTPageState createState() => _OPTPageState();
}

class _OPTPageState extends State<OPTPage> {
  final int digits = 6;
  final ScrollController _scrollController = ScrollController();
  double _position = 0;
  PhoneVerification _phoneVerification;
  bool _isSuccess = false;
  List _code;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    keyboardBlock.listenToKeyboard(context);

    _handleSuccessVerification();

    _authVerification(context);

    return Scaffold(
      appBar: ConstantWidget.appBarGreen,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: SizeConfig.height,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: _heightOfVictor(),
                  width: SizeConfig.width,
                  child: TextAndCustomPaint(
                    title: 'Back',
                  ),
                ),
                Container(
                  height: SizeConfig.height - _heightOfVictor() - 45,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PhoneTextValidation(
                        phone: widget.phone,
                        code: widget.code,
                      ),

                      HorizontalSpace(of: 35),
                      DigitalFields(digits: digits, code: _code),

                      TextWithKeyboardAnimation(position: _position),

                      // HorizontalSpace(of: 35),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: RegFAB(isSuccess: _isSuccess, onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InformationSignUp(),));



      },),
    );
  }

  @override
  void deactivate() {
    Provider.of<ChangeVerificationState>(context, listen: false).digits =
        List(6);
    _code = null;
    super.deactivate();
  }

  @override
  void dispose() {
    keyboardBlock.dispose();

    super.dispose();

    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();

    _phoneVerification = PhoneVerification(context: context)
      ..phoneVerification(widget.code + widget.phone.replaceAll(' ', ''));

    _scrollController.addListener(() {
      print(_scrollController.position.pixels);
      setState(() {
        _position = _scrollController.position.pixels;
      });
    });
  }

  Future _authVerification(BuildContext context) async {
    var watch = context.watch<ChangeVerificationState>();
    // var read = context.read<ChangeVerificationState>();
    print(watch.verificationId);
    print(watch.isFullDigit);

    if (watch.isFullDigit && watch.verificationId != null) {
      AuthCredential auth = await _phoneVerification.phoneValidationComplete();
      print(auth?.asMap());

      print('this');
    }
  }

  void _handleSuccessVerification() {
    var watch = context.watch<ChangeVerificationState>();
    switch (watch.status) {
      case VerificationState.VERIFIED:
        print('isVerified');
        this._code = watch.digits;
        setState(() {
          _isSuccess = true;
        });
        break;
      case VerificationState.NONE_VERIFIED:
        print('none');

        setState(() {
          _isSuccess = false;
        });
        break;
      case VerificationState.VERIFYING:
        // showDialogLogin(context);
        break;
      case VerificationState.WRONG:
        // showDialogLogin(context);
        print('this wrong code');

        break;
      default:
    }
  }

  double _heightOfVictor() {
    return SizeConfig.orientation == Orientation.portrait
        ? getProportionateScreenWidth(240)
        : getHeightWhenOrientationLand(235, 220);
  }
}
