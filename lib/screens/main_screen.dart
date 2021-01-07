import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tree_walker/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tree_walker/models/user.dart';
import 'package:tree_walker/services/firestore_service.dart';

//////////// my tutorial "Future" ////////////
//User loggedInUser;
final _auth = FirebaseAuth.instance;
final loggedInUser = _auth.currentUser;
final db = FirestoreService();
final user = db.getUser(loggedInUser.uid);  //return Future<OurUser>
//can't get OurUser

//final u = db.readUser1(loggedInUser.uid);
//OurUser u1 = db.getOurUser();

//Future
void getOurUserT() async {
  final _auth = FirebaseAuth.instance;
  final loggedInUser = _auth.currentUser;
  final db = FirestoreService();
  OurUser user = await db.getUser(loggedInUser.uid);  //return OurUser

  print(user.fullName);

  //return user;
}
//================OK=======
OurUser userTest;  //
void getOurUserT1() async {
  final _auth = FirebaseAuth.instance;
  final loggedInUser = _auth.currentUser;
  final db = FirestoreService();
  userTest = await db.getUser(loggedInUser.uid);  //get OurUser

  print(userTest.fullName);

  //return user;
}
//================
OurUser get(OurUser u){
  return u;
}
////////////////////////////////////



class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';
  //OurUser ourUserW;  //ok

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _auth = FirebaseAuth.instance;
  //FirebaseUser loggedInUser;
//-------------ok---------
  OurUser ourUser;

  void getOurUser() async {
    final _auth = FirebaseAuth.instance;
    final loggedInUser = _auth.currentUser;
    final db = FirestoreService();
    ourUser = await db.getUser(loggedInUser.uid);  //get OurUser

    print(ourUser.fullName);

  }
  //------------------------

  @override
  void initState(){
    super.initState();

    //ourUser = widget.ourUserW;  //ok
    getOurUser();
    getCurrentUser();
  }
  void getCurrentUser() async{
    try {
      final user = _auth.currentUser;
      if (user != null) {
        //loggedInUser = user;
        //print(loggedInUser.email);
        //print(user.email);
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        //title: Text('⚡️Chat'),
        title: Text('⚡️Main'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration: kMainTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //final user = db.getUser(loggedInUser.uid);
                      ////String u = user.then((value) => value.fullName)
                      //print(user);
                      //OurUser u = getOurUser1().then((value) => get(value));
                      //Implement send functionality.

                      //getOurUser();
                      print("ourUser -- ${ourUser.email}");
                      print("ourUser -- ${ourUser.trees}");

                      //final db = FirestoreService();

                      //final u = db.readUser1(loggedInUser.uid);
                      //OurUser u2 = db.getOurUser();

                      //print(" u1-- ${u2.fullName}");
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            Text(ourUser.email)
          ],
        ),
      ),
    );
  }
}
