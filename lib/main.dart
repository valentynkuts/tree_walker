import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tree_walker/screens/leaderboard_screen.dart';
import 'package:tree_walker/screens/pedometer_screen.dart';
import 'package:tree_walker/screens/welcome_screen.dart';
import 'package:tree_walker/screens/login_screen.dart';
import 'package:tree_walker/screens/registration_screen.dart';
import 'package:tree_walker/screens/main_screen.dart';
import 'package:tree_walker/screens/chat_screen.dart';
import 'package:tree_walker/screens/pedometer_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TreeWalker());
}

class TreeWalker extends StatelessWidget {
  //PageController _pageController;  //todo

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id :(context)=> WelcomeScreen(),
        LoginScreen.id :(context)=> LoginScreen(),
        RegistrationScreen.id :(context)=> RegistrationScreen(),
        MainScreen.id :(context)=> MainScreen(),
        ChatScreen.id :(context)=> ChatScreen(),
        PedometerScreen.id :(context)=> PedometerScreen(),
        LeaderboardScreen.id :(context)=> LeaderboardScreen(),
      },
      // theme: ThemeData.dark().copyWith(
      //   primaryColor: Color(0xFF0f0f1e),  //bar
      //   scaffoldBackgroundColor: Color(0xFF0f0f1e),
      // ),
    );
  }
}
