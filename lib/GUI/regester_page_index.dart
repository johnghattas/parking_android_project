import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/change_verification_state.dart';
import '../shared/validatioin_phone_helper.dart';
import 'confirm_OTP.dart';
import '../shared/constant_widget.dart';
import '../shared/country_field_validate.dart';
import '../shared/screen_sized.dart';
import '../widgets/country_code_field_hint.dart';
import '../widgets/custom_continue_widget.dart';
import '../widgets/text_custom_paint.dart';

class RegisterIndex extends StatefulWidget {
  @override
  _RegisterIndexState createState() => _RegisterIndexState();
}

class _RegisterIndexState extends State<RegisterIndex> {
  FieldPhoneValidate _fieldPhoneValidate = FieldPhoneValidate('EG');
  FocusNode _focusNode;

  bool _isValid = false;

  ScrollController _scrollController;

  String _phoneNumber;

  String _code = '+20';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _focusNode = FocusNode();
    _focusNode.addListener(() async {
      if (_focusNode.hasFocus) {
        await Future.delayed(Duration(milliseconds: 600));

        scrollToBottom(_scrollController);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    print(SizeConfig.bottom);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      extendBody: true,
      appBar: ConstantWidget.appBarGreen,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: SizeConfig.height,
          child: SingleChildScrollView(
            controller: _scrollController,
            primary: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: SizeConfig.orientation == Orientation.portrait
                          ? getProportionateScreenWidth(240)
                          : getHeightWhenOrientationLand(235, 220),
                      width: SizeConfig.width,
                      child: TextAndCustomPaint(
                        title: 'Back',
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      right: 0,
                      left: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            onChanged: (value) => context.read<ChangeVerificationState>().changeAdmin(value),
                            value: context.watch<ChangeVerificationState>().isAdmin,
                          ),
                          Text(
                            'Sign up like owner',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                letterSpacing: 0.65),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                VerticalSpacing(of: 40),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        joinOurCompanyText(),
                        HorizontalSpace(of: 35),
                        //todo make text field
                        CountryCodeFieldHint(
                          onChangedCountry: (value) async {
                            _code = value.dialCode;
                            _fieldPhoneValidate.countryCode = value.code;
                            _isValid = await checkNumberFromCode(_phoneNumber,
                                _fieldPhoneValidate, _scrollController);
                            if(!mounted)
                              return;
                            setState(() {});
                          },
                          focusNode: _focusNode,
                          initialCode: 'EG',
                          onChange: (value) async {
                            _phoneNumber = value;
                            _isValid = await checkNumberFromCode(
                                value, _fieldPhoneValidate, _scrollController);
                            setState(() {});
                          },
                          onTap: () {
                            scrollToBottom(_scrollController);
                          },
                        ),

                        HorizontalSpace(of: 35),
                        privacyTextWidget(),

                        HorizontalSpace(of: 35),
                        CustomContinueButton(
                            title: 'Continue',
                            isEnable: _isValid,
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => OPTPage(phone: _phoneNumber, code: _code,)));
                            }),

                        VerticalSpacing(of: 30)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
