import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tree_walker/components/reusable_card.dart';
import 'package:tree_walker/components/round_icon_button.dart';
import 'package:tree_walker/constants.dart';
import 'package:tree_walker/models/user.dart';
import 'package:tree_walker/services/firestore_service.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'leaderboard_screen.dart';
import 'main_screen.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class PedometerScreen extends StatefulWidget {
  static const String id = 'pedometer_screen';
  OurUser oUserPedometer;

  PedometerScreen({@required this.oUserPedometer});

  @override
  _PedometerScreenState createState() => _PedometerScreenState();
}

class _PedometerScreenState extends State<PedometerScreen> {
  FirestoreService db = FirestoreService();
  OurUser oUserP;
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  @override
  void initState() {
    super.initState();
    oUserP = widget.oUserPedometer;

    setState(() {
      _steps = oUserP.steps.toString();
    });

    initPlatformState();
  }

  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps.toString(); // steps
      oUserP.steps = event.steps;
      db.updateUserSteps(oUserP);

      if (oUserP.steps % 10000 == 0) {
        oUserP.treeCoins++;
        db.updateUserTreeCoins(oUserP);
      }
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    setState(() {
      _status = 'Pedestrian Status not available';
    });
  }

  void onStepCountError(error) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PEDOMETER'),
        backgroundColor: Colors.teal, //Color(0xFF0f0f1e),
      ),
      backgroundColor: Colors.teal, //Color(0xFF0f0f1e),
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
                    style: kNumberTextStyle,
                  ),
                  SizedBox(height: 100.0),
                  Text(
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
                          RoundIconButton(
                              icon: FontAwesomeIcons.angleLeft,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen(
                                              userMain: oUserP,
                                              testt: "HELLO FROM Pedometer",
                                            )));
                              }),
                          SizedBox(width: 70.0),
                          RoundIconButton(
                              icon: FontAwesomeIcons.angleRight,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LeaderboardScreen(
                                              ourUserLeaderB: oUserP,
                                            )));
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
