import 'package:tree_walker/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:tree_walker/components/rounded_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: Duration(seconds: 1), vsync: this
        //upperBound: 100.0
        );

    /* animation = CurvedAnimation(
      parent: controller,
      //curve: Curves.decelerate
      curve: Curves.easeIn
    );
*/
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward(); //small→big
    //controller.reverse(from: 1.0); //big→small

    /*animation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        controller.reverse(from: 1.0);
      } else if(status == AnimationStatus.dismissed){
         controller.forward();
      }
      //print(status);
    });*/

    controller.addListener(() {
      setState(() {});
      //print(controller.value);
      // print(animation.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.red.withOpacity(controller.value),
      //backgroundColor: Colors.white,
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                    //height: controller.value,
                    //height: animation.value * 100,
                  ),
                ),
                Text(
                  'Tree walker',
                  //'${controller.value.toInt()}%',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'log in',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: 'Register',
              colour: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}


/*
TypewriterAnimatedTextKit(
text:['Tree walker'],
//'${controller.value.toInt()}%',
textStyle: TextStyle(
fontSize: 45.0,
fontWeight: FontWeight.w900,
),*/

/*Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),*/
