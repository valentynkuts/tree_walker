// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tree_walker/components/reusable_card.dart';
import 'package:tree_walker/components/rounded_button.dart';
import 'package:tree_walker/main.dart';
import 'package:tree_walker/screens/login_screen.dart';
import 'package:tree_walker/screens/main_screen.dart';
import 'package:tree_walker/screens/registration_screen.dart';
import 'package:tree_walker/screens/welcome_screen.dart';

void main() {

  testWidgets('Test to see MaterialApp widget is in Tree', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TreeWalker());

    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Test to see widget with text is in tree', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
        MaterialApp(
          home: WelcomeScreen(),
        )
    );

    //expect(find.byType(Text), findsWidgets);
    expect(find.text('Tree walker'), findsWidgets);
  });


  // testWidgets('Test to see ModalProgressHUD widget is in Tree', (WidgetTester tester) async {
  //   await tester.pumpWidget(LoginScreen());
  //   //await tester.pumpAndSettle();
  //   expect(find.byType(ModalProgressHUD), findsOneWidget);
  // });


}
