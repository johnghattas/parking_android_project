// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_project/GUI/login_page.dart';

import 'package:parking_project/main.dart';

void main() {

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: LoginPage()));


    // Verify that our counter starts at 0.
    expect(find.byKey(Key('login_phone')), findsOneWidget);

    final button = find.byKey(Key('login_button'));
    tester.tap(button, pointer: 1);
    // tester.pumpFrames(target, maxDuration)
    // expect(actual, matcher)
    // expect(find.text('1'), findsNothing);

    //
    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
