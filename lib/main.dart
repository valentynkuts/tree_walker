import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tree_walker/screens/welcome_screen.dart';
import 'package:tree_walker/screens/login_screen.dart';
import 'package:tree_walker/screens/registration_screen.dart';
import 'package:tree_walker/screens/main_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id :(context)=> WelcomeScreen(),
        LoginScreen.id :(context)=> LoginScreen(),
        RegistrationScreen.id :(context)=> RegistrationScreen(),
        ChatScreen.id :(context)=> ChatScreen()
      },
    );
  }
}
