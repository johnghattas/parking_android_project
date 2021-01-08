import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:parking_project/providers/change_verification_state.dart';
import 'package:parking_project/services/phone_verification.dart';

class MocFirebaseAuth extends Mock implements FirebaseAuth {}

class MocPhoneAuthCredential extends Mock implements PhoneAuthCredential {}

class MocPhoneVerification extends Mock implements PhoneVerification {}

class MocBuildContext extends Mock implements BuildContext {
  read<T>() {
    return ChangeVerificationState()..digits = [1,2,3,4,5];
  }watch<T>() {
    return ChangeVerificationState()..digits = [1,2,3,4,5];
  }
}

class MockChangeState extends Mock implements ChangeVerificationState {
}

class MocFirebase extends Mock implements Firebase {}

main() {
    test('this test for the digital', () async {
      final mocBuildContext = MocBuildContext();
      final mocMockProvider = MockChangeState();
      final mocFirebase = MocFirebaseAuth();
      final mocPhoneAuthCredential = MocPhoneAuthCredential();

      when(mocPhoneAuthCredential.smsCode).thenReturn('gdfgsdg');
      // when(mocBuildContext.watch<ChangeVerificationState>()).thenReturn(MockChangeState());

      PhoneVerification phoneVerification;
      try {
        phoneVerification.getCodeFromCredential(mocPhoneAuthCredential);
      } catch (e) {
        expect(e, isException);
      }
    });

  test('this test for the phoneValidationComplete', () async {
      final mocBuildContext = MocBuildContext();
      final mocMockProvider = MockChangeState();
      final mocFirebase = MocFirebaseAuth();
      final mocPhoneAuthCredential = MocPhoneAuthCredential();

      when(mocPhoneAuthCredential.smsCode).thenReturn('gdfgsdg');
      // when(mocBuildContext.watch<ChangeVerificationState>()).thenReturn(MockChangeState());

      PhoneVerification phoneVerification ;
      try {
        phoneVerification.phoneValidationComplete();
      } catch (e) {
        expect(e, isException);
      }
    });


  test('test the test ', () async {
    var time =  DateTime.now();
    await Future.delayed(Duration(seconds: 1));

    print('the time of this sequense is ${DateTime.now().difference(time) }');
  });
}
