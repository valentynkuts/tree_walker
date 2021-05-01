import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tree_walker/main.dart';
import 'package:tree_walker/screens/welcome_screen.dart';

void main() {
  testWidgets('Test to see MaterialApp widget is in Tree',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TreeWalker());

    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Test to see widget with text is in tree',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: WelcomeScreen(),
    ));

    //expect(find.byType(Text), findsWidgets);
    expect(find.text('Tree walker'), findsWidgets);
  });

  // testWidgets('Test to see ModalProgressHUD widget is in Tree', (WidgetTester tester) async {
  //   await tester.pumpWidget(LoginScreen());
  //   //await tester.pumpAndSettle();
  //   expect(find.byType(ModalProgressHUD), findsOneWidget);
  // });
}
