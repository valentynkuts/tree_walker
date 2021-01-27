import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tree_walker/components/reusable_card.dart';
import 'package:tree_walker/components/round_icon_button.dart';
import 'package:tree_walker/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tree_walker/models/user.dart';
import 'package:tree_walker/services/firestore_service.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pedometer/pedometer.dart';

import 'leaderboard_screen.dart';
import 'main_screen.dart';


String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class PedometerScreen extends StatefulWidget {
  static const String id = 'pedometer_screen';
  OurUser ourUser;

  PedometerScreen({@required this.ourUser});

  @override
  _PedometerScreenState createState() => _PedometerScreenState();
}


class _PedometerScreenState extends State<PedometerScreen> {

  FirestoreService db = FirestoreService();
  OurUser oUser;
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?',
      _steps = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    oUser = widget.ourUser;
    print("--- initState Pedometr --");
    print(oUser.steps);
    print("-----");
   // _steps = oUser.steps.toString();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString(); // steps
      oUser.steps = int.parse(_steps);
      db.updateUserSteps(oUser);
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

//-------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PEDOMETER'),
        backgroundColor: Color(0xFF0f0f1e),
      ),
      backgroundColor: Color(0xFF0f0f1e),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        Expanded(
        flex: 3,
        child: ReusableCard(
          colour: kActiveCardColour,
          cardChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'STEPS TAKEN:',
              style: kLabelTextStyle,
            ),
            Text(
              _steps,
              style: kLabelTextStyle,
            ),
            // Divider(
            //   height: 100,
            //   thickness: 0,
            //   color: Colors.white,
            // ),
            SizedBox(height: 100.0),
            Text(
              //'Pedestrian status:',
              'PEDESTRIAN STATUS:',
              style: kLabelTextStyle,
            ),
            Icon(
              _status == 'walking'
                  ? Icons.directions_walk
                  : _status == 'stopped'
                  ? Icons.accessibility_new
                  : Icons.sentiment_satisfied_alt,
              color: Colors.white70,
              size: 100,
            ),
            Center(
              child: Text(
                _status,
                style: _status == 'walking' || _status == 'stopped'
                    ? TextStyle(fontSize: 30, color: Colors.white70)
                    : TextStyle(fontSize: 30, color: Colors.white70),
              ),
            )
          ],
        ),
      ),
    ),
    //--------------


    Expanded(
    child: Row(
    children: [
    Expanded(
    child: ReusableCard(
    colour: kActiveCardColour,
    cardChild: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    // FloatingActionButton(
    //     backgroundColor: Color(0xff4c4f5e),
    //     child: Icon(
    //       Icons.add, color: Colors.white,),
    //     onPressed: null
    // ),
    RoundIconButton(
    icon: FontAwesomeIcons.angleLeft,
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => MainScreen(
    userFromlogin: oUser,
    testt: "HELLO FROM Pedometer",
    )));

    /*Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MainScreen(
                                              userFromlogin: widget.ourUser,
                                              testt: "HELLO FROM leaderbord",
                                            )));*/

    //Navigator.pushNamed(context, MainScreen.id);
    // setState(() {
    //   ourUser.treeCoins--;
    // });
    // db.updateUserTreeCoins(ourUser);
    }),
    SizedBox(width: 70.0),
    // FloatingActionButton(
    //     backgroundColor: Color(0xff4c4f5e),
    //     child: Icon(
    //       Icons.add, color: Colors.white,),
    //     onPressed: null
    // ),
    RoundIconButton(
    icon: FontAwesomeIcons.angleRight,
    onPressed: () {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => LeaderboardScreen(
    ourUser: widget.ourUser,
    )));

    //Navigator.pushNamed(context, LeaderboardScreen.id);
    // setState(() {
    //   ourUser.treeCoins++;
    // });
    // db.updateUserTreeCoins(ourUser);
    }),
    ],
    ),
    ],
    ),
    ),
    ),
    ],
    )),
    // BottomButton(
    //     buttonTitle: 'RE-CALCULATE',
    //     onTap: () {
    //       Navigator.pop(context);
    //     }),
    ],
    )
    ,
    );
  }
//-------------
/*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pedometer'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Steps taken:',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                _steps,
                style: TextStyle(fontSize: 60),
              ),
              Divider(
                height: 100,
                thickness: 0,
                color: Colors.white,
              ),
              Text(
                'Pedestrian status:',
                style: TextStyle(fontSize: 30),
              ),
              Icon(
                _status == 'walking'
                    ? Icons.directions_walk
                    : _status == 'stopped'
                    ? Icons.accessibility_new
                    : Icons.error,
                size: 100,
              ),
              Center(
                child: Text(
                  _status,
                  style: _status == 'walking' || _status == 'stopped'
                      ? TextStyle(fontSize: 30)
                      : TextStyle(fontSize: 20, color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }*/
}
