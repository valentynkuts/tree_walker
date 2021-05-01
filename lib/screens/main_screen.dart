import 'package:flutter/material.dart';
import 'package:tree_walker/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tree_walker/models/user.dart';
import 'package:tree_walker/screens/pedometer_screen.dart';
import 'package:tree_walker/screens/shop_screen.dart';
import 'package:tree_walker/services/firestore_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/reusable_card.dart';
import '../constants.dart';
import '../components/round_icon_button.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';
  final OurUser userMain;
  String testt;

  MainScreen({@required this.userMain, this.testt});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FirestoreService db = FirestoreService();
  final _auth = FirebaseAuth.instance;
  OurUser ourUserMain;
  User loggedInUser; //????

  Future<OurUser> getOurUser() async {
    final loggedInUser = _auth.currentUser;
    ourUserMain = await db.getUser(loggedInUser.uid);

    return ourUserMain;
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    ourUserMain = widget.userMain;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal, //Color(0xFF0f0f1e),
        appBar: AppBar(
          title: Text(ourUserMain.fullName.toUpperCase()),
          centerTitle: true,
          backgroundColor: Colors.teal, //Color(0xFF0f0f1e)
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
                              ourUserMain.treeCoins.toString(),
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
                        cardChild: Column(
                          //TODO
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ourUserMain.trees.toString(),
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
                              ourUserMain.steps.toString(),
                              style: kNumberTextStyle,
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
                            RoundIconButton(
                                icon: FontAwesomeIcons.angleLeft,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ShopScreen(
                                                ourUserShop: ourUserMain,
                                              )));
                                }),
                            SizedBox(width: 70.0),
                            RoundIconButton(
                                icon: FontAwesomeIcons.angleRight,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PedometerScreen(
                                                oUserPedometer: ourUserMain,
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
        ));
  }
}
