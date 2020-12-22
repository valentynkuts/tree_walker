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
      /*theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),*/
      //////home: WelcomeScreen(),
      // initialRoute: 'welcome_screen',
      // routes: {
      //   'welcome_screen':(context)=> WelcomeScreen(),
      //   'login_screen':(context)=> LoginScreen(),
      //   'registration_screen':(context)=> RegistrationScreen(),
      //   'chat_screen':(context)=> ChatScreen()
      // },

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
