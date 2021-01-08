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
      verificationCompleted: (phoneAuthCredential) async{
        UserCredential credential;
        try {
          credential = await _auth.signInWithCredential(phoneAuthCredential);
        } catch (e) {
          print(e);


          print('this error'+ e.runtimeType.toString());
          changeStatus..setStatus(VerificationState.WRONG)..isFullDigit = false;
          return null;

        }

        if (credential?.user != null) {
          getCodeFromCredential(phoneAuthCredential);
          changeStatus..verificationId = null..isFullDigit = false..setStatus(VerificationState.VERIFIED);
        } else {
          changeStatus.setStatus(VerificationState.NONE_VERIFIED);

        }

      },
      verificationFailed: (error) {

        changeStatus.setError(error.message);

        print('this ex');

        throw Exception(error);

      },
      codeSent: (verificationId, forceResendingToken) {

        print('this is the verification id $verificationId');

        changeStatus..setStatus(VerificationState.VERIFYING)..verificationId = verificationId;

        print('here');

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
      credential = PhoneAuthProvider.credential(verificationId: changeVer.verificationId, smsCode: smsCode);
    UserCredential credential2;

    credential2 = await _makeUserSignIn(credential);

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


  User get user => _auth.currentUser;

  Future<UserCredential> _makeUserSignIn(AuthCredential authCredential) async{

    var changeVer = context.read<ChangeVerificationState>();

    UserCredential credential;
    try {
      credential = await _auth.signInWithCredential(authCredential);
    } catch (e) {
      print(e.runtimeType);
      changeVer..setStatus(VerificationState.WRONG)..isFullDigit = false;
      return null;
    }

    return credential;
  }
}
