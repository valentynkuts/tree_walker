import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tree_walker/components/round_icon_button.dart';
import 'package:tree_walker/models/user.dart';
import 'package:tree_walker/screens/main_screen.dart';
import 'package:tree_walker/screens/pedometer_screen.dart';
import '../constants.dart';
import '../components/reusable_card.dart';
import '../components/bottom_button.dart';

class LeaderboardScreen extends StatefulWidget {
  static const String id = 'leaderboard_screen';

  // final String bmiResult;
  // final String resultText;
  // final String interpretation;
  final OurUser ourUser;

  // LeaderboardScreen({@required this.bmiResult, @required this.resultText,@required this.interpretation});
  LeaderboardScreen({@required this.ourUser});

  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LEADER BOARD'),
        backgroundColor: Color(0xFF0f0f1e),
      ),
      backgroundColor: Color(0xFF0f0f1e),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.all(15.0),
            alignment: Alignment.bottomLeft,
            child: Text(
              'Your Result',
              style: kTitleTextStyle,
            ),
          )),
          Expanded(
            flex: 2,
            child: ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Normal',
                    //resultText.toUpperCase(),
                    style: kResultTextStyle,
                  ),
                  Text(
                    '18.3',
                    //bmiResult,
                    style: kBMITextStyle,
                  ),
                  Text(
                    'Your BMI result is quite low, you should eat more!',
                    //interpretation,
                    textAlign: TextAlign.center,
                    style: kBodyTextStyle,
                  ),
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
                      Text(
                        'Navigation',
                        style: kLabelTextStyle,
                      ),
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
                                              userFromlogin: widget.ourUser,
                                              testt: "HELLO FROM leaderbord",
                                            )));

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
                                Navigator.pushNamed(
                                    context, PedometerScreen.id);
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
      ),
    );
  }
}
