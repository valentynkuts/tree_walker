import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tree_walker/components/round_icon_button.dart';
import 'package:tree_walker/models/user.dart';
import 'package:tree_walker/screens/pedometer_screen.dart';
import 'package:tree_walker/services/firestore_service.dart';
import '../constants.dart';
import '../components/reusable_card.dart';
import '../shared/loading.dart';

class LeaderboardScreen extends StatefulWidget {
  static const String id = 'leaderboard_screen';

  final OurUser ourUserLeaderB;

  LeaderboardScreen({@required this.ourUserLeaderB});

  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<OurUser> listUsers;
  FirestoreService db = FirestoreService();
  int numOfUsers = 8;
  bool loading = false;
  int amountOfUsers = 0;
  OurUser oUserLB;

  Future<List<OurUser>> getListUser(int num) async {
    final listOfUsers = await db.getTenBestUsers(num);
    return listOfUsers;
  }

  @override
  void initState() {
    super.initState();
    oUserLB = widget.ourUserLeaderB;
    try {
      getListUser(numOfUsers).then((list) {
        setState(() {
          listUsers = list;
          amountOfUsers = listUsers.length;
        });
        if (listUsers == null) {
          //todo
          setState(() {
            loading = true;
          });
        } else {
          setState(() {
            loading = false;
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('LEADER BOARD'),
              backgroundColor: Colors.teal,
            ),
            backgroundColor: Colors.teal,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              for (var i = 0; i < amountOfUsers; i++)
                                Container(
                                  height: 100.0,
                                  alignment: Alignment.center,
                                  child: Text(
                                      listUsers[i].fullName +
                                          " : " +
                                          listUsers[i].steps.toString() +
                                          " steps ",
                                      style: TextStyle(
                                        fontFamily: 'Pacifico',
                                        color: Colors.white70,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 30.0,
                                      )),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1.0, color: Colors.grey)),
                                  ),
                                ),
                            ],
                          ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIconButton(
                                    icon: FontAwesomeIcons.angleLeft,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PedometerScreen(
                                                    oUserPedometer: oUserLB,
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
