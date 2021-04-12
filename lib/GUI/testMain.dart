import 'package:flutter/material.dart';
import 'package:parking_project/providers/change_verification_state.dart';
import 'package:provider/provider.dart';

main() {
  runApp(Provider<ChangeVerificationState>(
    create: (context) => ChangeVerificationState(),
    child: MaterialApp(
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondTestApp(),));
                // print('this text here');
              },
              child: Text('this'),
            )
          ],
        ),
      ),
    );
  }
}

class SecondTestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Consumer<ChangeVerificationState>(
        builder: (context, value, child) {
          // print(value.verificationId);
          return child!;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(onPressed: () {
              print(context.read<ChangeVerificationState>().verificationId);
            })
          ],
        ),
      ),
    ));
  }
}
