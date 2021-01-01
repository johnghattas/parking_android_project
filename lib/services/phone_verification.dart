import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parking_project/providers/change_verification_state.dart';


class PhoneVerification {
  FirebaseAuth _auth;


  PhoneVerification({this.context}){
    _auth = FirebaseAuth.instance;
  }


  final BuildContext context;

  Future<void> phoneVerification (String phoneNumber) async{
    var changeStatus = Provider.of<ChangeVerificationState>(context, listen: false);
    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 60),
      verificationCompleted: (phoneAuthCredential) {

        getCodeFromCredential(phoneAuthCredential);
        changeStatus.setStatus(VerificationState.VERIFIED);

      },
      verificationFailed: (error) {

        changeStatus.setStatus(VerificationState.NONE_VERIFIED);

        throw Exception(error);

      },
      codeSent: (verificationId, forceResendingToken) {

        print('this is the verification id $verificationId');

        changeStatus..setStatus(VerificationState.VERIFYING)..verificationId = verificationId;

      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }


  Future<AuthCredential> phoneValidationComplete() async{
    var changeVer = context.watch<ChangeVerificationState>();
    var list = changeVer.digits;

    print(list.toString().replaceFirst('[', '').replaceFirst(']', '').replaceAll(', ', ''));
    String smsCode = list.toString().replaceFirst('[', '').replaceFirst(']', '').replaceAll(', ', '');
    assert(smsCode != null);

    print(smsCode);

    AuthCredential credential;
    UserCredential credential2;

    try {
      credential = PhoneAuthProvider.credential(verificationId: changeVer.verificationId, smsCode: smsCode);
    credential2 = await _auth.signInWithCredential(credential);
    } catch (e) {
      print(e.runtimeType);
      changeVer..setStatus(VerificationState.WRONG)..isFullDigit = false;
      return null;
    }


    if (credential2?.user != null) {
      changeVer..verificationId = null..isFullDigit = false..setStatus(VerificationState.VERIFIED);
    } else {
      changeVer.setStatus(VerificationState.NONE_VERIFIED);

    }

    return credential;
  }

  getCodeFromCredential(PhoneAuthCredential phone, ) {
    var smsCode = phone.smsCode;
    print(smsCode);
    var changeVer = context.read<ChangeVerificationState>();
    print(changeVer.runtimeType);

    try {

      changeVer.digits = smsCode.split('').map((e) => int.parse(e)).toList();

    } catch (e) {
      throw e;
    }

  }
}
