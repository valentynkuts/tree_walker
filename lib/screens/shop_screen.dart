import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tree_walker/components/round_icon_button.dart';
import 'package:tree_walker/components/tree_card.dart';
import 'package:tree_walker/models/user.dart';
import 'package:tree_walker/screens/main_screen.dart';
import 'package:tree_walker/screens/pedometer_screen.dart';
import 'package:tree_walker/services/firestore_service.dart';
import '../constants.dart';
import '../components/reusable_card.dart';
import '../components/bottom_button.dart';
import '../shared/loading.dart';

class ShopScreen extends StatefulWidget {
  static const String id = 'shop_screen';

  final OurUser ourUserShop;

  ShopScreen({@required this.ourUserShop});

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  //var priceOfTree = [ 11, 22, 15, 18, 12, 9, 8, 14];
  //var priceOfTree = ['11.0', '22.0', '15,8', '18.2', '12.7', '9.3', '8.0', '14.5'];
  var priceOfTree = ['11', '22', '15', '18', '12', '9', '8', '14'];

  var trees = [
    'The Oaks',
    'Black Cherry',
    'White Ash',
    'Black Locust',
    'Hawthorn',
    'Shagbark Hickory',
    'Tulip Tree',
    'Eastern White Pine'
  ];
  List<OurUser> listUsers;
  FirestoreService db = FirestoreService();
  int numOfTrees = 8;
  bool loading = false;
  int amountOfUsers = 0;
  OurUser oUserS;


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
    oUserS = widget.ourUserShop;

    print(".......SHOP screen ......");
    try {

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
        title: Text('SHOP'),
        backgroundColor: Colors.teal, //Color(0xFF0f0f1e),
      ),
      backgroundColor: Colors.teal,//Color(0xFF0f0f1e),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: ReusableCard(
              colour: Colors.teal[800],//kActiveCardColour,
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
                        for (var i = 0; i < numOfTrees; i++)
                          TreeCard(
                              image: 'images/tree.png',
                              treeName: trees[i],
                              price: priceOfTree[i].toString()+".0" ,
                              onPress: (){
                                int price = int.parse(priceOfTree[i]);
                                if(oUserS.treeCoins >=  price){
                                  oUserS.treeCoins  = oUserS.treeCoins -  price;
                                  oUserS.trees++;
                                }
                              }
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
                                  icon: FontAwesomeIcons.angleRight,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MainScreen(
                                              userMain: oUserS,
                                              testt: "HELLO FROM Pedometer",
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


/*
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
),*/
