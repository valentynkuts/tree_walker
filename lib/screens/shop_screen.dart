import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tree_walker/components/round_icon_button.dart';
import 'package:tree_walker/components/tree_card.dart';
import 'package:tree_walker/models/user.dart';
import 'package:tree_walker/screens/main_screen.dart';
import 'package:tree_walker/services/firestore_service.dart';
import '../constants.dart';
import '../components/reusable_card.dart';
import '../shared/loading.dart';

class ShopScreen extends StatefulWidget {
  static const String id = 'shop_screen';

  final OurUser ourUserShop;

  ShopScreen({@required this.ourUserShop});

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
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
    final listOfUsers = await db.getTenBestUsers(num);

    return listOfUsers;
  }

  @override
  void initState() {
    super.initState();
    oUserS = widget.ourUserShop;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('SHOP'),
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
                    colour: Colors.teal[800], //kActiveCardColour,
                    cardChild: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              for (var i = 0; i < numOfTrees; i++)
                                TreeCard(
                                    image: 'images/tree.png',
                                    treeName: trees[i],
                                    price: priceOfTree[i].toString() + ".0",
                                    onPress: () {
                                      int price = int.parse(priceOfTree[i]);
                                      if (oUserS.treeCoins >= price) {
                                        oUserS.treeCoins =
                                            oUserS.treeCoins - price;
                                        oUserS.trees++;
                                        db.updateUserTreeCoins(oUserS);
                                        db.updateUserTrees(oUserS);
                                      }
                                    }),
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
                                                    testt:
                                                        "HELLO FROM Pedometer",
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
