import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:tree_walker/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tree_walker/models/user.dart';
import 'package:tree_walker/screens/leaderboard_screen.dart';
import 'package:tree_walker/screens/pedometer_screen.dart';
import 'package:tree_walker/services/firestore_service.dart';

import 'package:tree_walker/screens/results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/icon_content.dart';
import '../components/reusable_card.dart';
import '../constants.dart';
import 'chat_screen.dart';
import 'results_page.dart';
import '../components/bottom_button.dart';
import '../components/round_icon_button.dart';
import 'package:tree_walker/calculator_brain.dart';

// enum Gender {
//   male,
//   female,
// }


//FirestoreService db = FirestoreService();
//User loggedInUser;
//final _auth = FirebaseAuth.instance;


class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';

  //OurUser ourUserW;  //ok

  final OurUser userFromlogin;
  String testt;

  //String TEST;

  MainScreen({@required this.userFromlogin, this.testt});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  FirestoreService db = FirestoreService();
  final _auth = FirebaseAuth.instance;
  OurUser ourUser;
  User loggedInUser; //????


  Future<OurUser> getOurUser() async {
    //final _auth = FirebaseAuth.instance;  /////// todo
    final loggedInUser = _auth.currentUser;
    //final db = FirestoreService();  ////// todo
    ourUser = await db.getUser(loggedInUser.uid); //get OurUser

    print("----getOurUser from MAIN---");
    print(ourUser.email);
    print("------------------");

    return ourUser;
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    }
    catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    print(".......MAIN screen ......");
    print(widget.userFromlogin.fullName); //TODO ????
    ourUser = widget.userFromlogin;
    print(ourUser.email);
    print(widget.testt);
    print("................");


    //getCurrentUser(); //todo

    /*getOurUser().then((user) { ////ok
        setState((){
             ourUser = user;
        });

    });*/

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF0f0f1e),
        appBar: AppBar(
            title: Text('MAIN'),
            centerTitle: true,
            backgroundColor: Color(0xFF0f0f1e)
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: ReusableCard(
                        colour: kInactiveCardColour,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ourUser.treeCoins.toString(),
                              //widget.userFromlogin.treeCoins.toString(),
                              style: kNumberTextStyle,
                            ),
                            Text(
                              'TREECOINS',
                              style: kLabelTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: ReusableCard(
                        colour: kInactiveCardColour,
                        cardChild: Column(         //TODO
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              //widget.userFromlogin.trees.toString(),
                              ourUser.trees.toString(),
                              style: kNumberTextStyle,
                            ),
                            Text(
                              'TREES',
                              style: kLabelTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: ReusableCard(
                        colour: kActiveCardColour,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'STEPS',
                              style: kLabelTextStyle,
                            ),
                            Text(
                              //widget.userFromlogin.steps.toString(),
                              ourUser.steps.toString(),
                              style: kNumberTextStyle,
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
                                    icon: FontAwesomeIcons.minus,
                                    onPressed: () {
                                      setState(() {
                                        //ourUser.steps--;
                                        widget.userFromlogin.steps--;
                                      });
                                     db.updateUserSteps(ourUser);
                                    }),
                                SizedBox(width: 70.0),
                                // FloatingActionButton(
                                //     backgroundColor: Color(0xff4c4f5e),
                                //     child: Icon(
                                //       Icons.add, color: Colors.white,),
                                //     onPressed: null
                                // ),
                                RoundIconButton(
                                    icon: FontAwesomeIcons.plus,
                                    onPressed: () {
                                      setState(() {
                                        //widget.userFromlogin.steps++;
                                        ourUser.steps++;
                                      });
                                      db.updateUserSteps(ourUser);

                                      if (ourUser.steps % 10000 == 0) {
                                        ourUser.treeCoins ++;
                                        db.updateUserTreeCoins(ourUser);
                                      }
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                )),

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
                                      Navigator.pushNamed(
                                          context, ChatScreen.id);
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
                                      // Navigator.pushNamed(context, PedometerScreen.id);
                                      //Navigator.pushNamed(context, LeaderboardScreen.id);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PedometerScreen(
                                                ourUser: ourUser,
                                              )));
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
            //     buttonTitle: 'CALCULATE',
            //     onTap: () {
            //       CalculatorBrain calc =
            //       CalculatorBrain(height: height, weight: weight);
            //
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => ResultsPage(
            //             bmiResult: calc.calculateBMI(),
            //             resultText: calc.getResult(),
            //             interpretation: calc.getInterpretation(),
            //           )));
            //     }),
          ],
        ));
  }
}


/////////////////
/*Expanded(
flex: 1,
child: ReusableCard(
colour: kActiveCardColour,
cardChild: Column(
mainAxisAlignment: MainAxisAlignment.center, // |
children: [
Text(
'STEPS',
style: kLabelTextStyle,
),
Row(
mainAxisAlignment: MainAxisAlignment.center,
// ---
crossAxisAlignment: CrossAxisAlignment.baseline,
// по линии
textBaseline: TextBaseline.alphabetic,
children: [
Text(
ourUser.steps.toString(), //'180'
style: kNumberTextStyle,
),
],
),
],
),
),
),
 */