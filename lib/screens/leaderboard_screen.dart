import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tree_walker/components/round_icon_button.dart';
import 'package:tree_walker/models/user.dart';
import 'package:tree_walker/screens/main_screen.dart';
import 'package:tree_walker/screens/pedometer_screen.dart';
import 'package:tree_walker/services/firestore_service.dart';
import '../constants.dart';
import '../components/reusable_card.dart';
import '../components/bottom_button.dart';
import '../shared/loading.dart';

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
  var arr = [
    'aaaa',
    'bbbb',
    'cccc',
    'dddd',
    'eeee',
    'ffff',
    'hhhh',
    'kkkk',
    'mmmm',
    'wwww'
  ];
  List<OurUser> listUsers;
  FirestoreService db = FirestoreService();
  int numOfUsers = 8;
  bool loading = false;
  int amountOfUsers = 0;
  OurUser oUser;

  // Future<List> getListUser() async {
  //
  //   //final db = FirestoreService();
  //   listUsers = await db.getTenBestUsers();
  //
  //   print("----getListUser from leaderboard--");
  //   print(listUsers);
  //   print("------------------");
  //
  //   return listUsers;
  // }

  Future<List<OurUser>> getListUser(int num) async {
    //final db = FirestoreService();
    final listOfUsers = await db.getTenBestUsers(num);

    print("----getListUser from leaderboard--");
    print(listOfUsers);
    print(listOfUsers.first.fullName);
    print("------------------");

    return listOfUsers;
  }

  @override
  void initState() {
    super.initState();
    oUser = widget.ourUser;

    print(".......leaderboars screen ......");
    try {
      getListUser(numOfUsers).then((list) {
        ////ok
        setState(() {
          listUsers = list;
          amountOfUsers = listUsers.length;
        });
        // listUsers = null;
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

        print(".......linitState ......");
        //print(listUsers[0].fullName);
      });

      //print(listUsers[0].fullName);

      // for (var u in listUsers) {
      //]   print(u.fullName);
      // }

      // print(listUsers.first);

      // final test = getListUser();
      //print(test);
      print("................");
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
                    cardChild: CustomScrollView(
                      //semanticChildCount: 10,
                      slivers: [
                        SliverList(
                          // delegate: SliverChildBuilderDelegate(
                          //   (context, index) {
                          //     return Container(
                          //       height: 100.0,
                          //       alignment: Alignment.center,
                          //       color: Colors.blue[100 * (index % 9)],
                          //       //child: Text("Menu Item $index"),
                          //       child: Text(
                          //         //"Menu Item " + arr[index],
                          //         listUsers[index].fullName +
                          //             " steps: " +
                          //             listUsers[index].steps.toString(),
                          //       ),
                          //     );
                          //   },
                          //   childCount: listUsers.length,
                          // ),
                          //----------
                          delegate: SliverChildListDelegate(
                            [
                              for (var i = 0; i < amountOfUsers; i++)
                                Container(
                                  height: 100.0,
                                  alignment: Alignment.center,
                                  //color: Colors.blue[100 * (i % 9)],
                                  //color: Color(0xFF0f0f1e),
                                  //child: Text("Menu Item $index"),
                                  child: Text(
                                      //"Menu Item " + arr[index],
                                      listUsers[i].fullName +
                                          " : " +
                                          listUsers[i].steps.toString() +
                                          " steps ",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      )),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0, color: Colors.grey)),
                                  // ListTile(
                                  //   title: Text(
                                  //       listUsers[i].fullName,
                                  //     style: TextStyle(
                                  //       color: Colors.white70,
                                  //     )
                                  //   ),
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
                                              builder: (context) =>
                                                  PedometerScreen(
                                                    ourUser: oUser,
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
                                      /* Navigator.pushNamed(
                                    context, PedometerScreen.id);*/

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
