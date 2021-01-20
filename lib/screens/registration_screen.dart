import 'package:flutter/material.dart';
import 'package:tree_walker/components/rounded_button.dart';
import 'package:tree_walker/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tree_walker/models/user.dart';
import 'package:tree_walker/services/firestore_service.dart';
import 'main_screen.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  //final db = FirestoreService();
  //OurUser _user;
  bool showSpinner = false;
  String email;
  String password;
  String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  username = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your username'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true, //for password
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //TODO
                  password = value;
                },
                //style: TextStyle(color: Colors.black),
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                colour: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    //print(email);
                    //print(password);

                    /*
                    OurUser _user = OurUser();
                     */
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      print(username);
                      print(newUser.user.uid);
                      print(newUser.user.email);
                      //----test----
                       OurUser _user = OurUser();
                      _user.uid = newUser.user.uid;
                      _user.email = newUser.user.email;
                      _user.fullName = username;
                      _user.steps = 0;
                      _user.treeCoins = 0;
                      _user.trees = 0;

                      final db = FirestoreService();
                      final res = await db.createUser(_user);
                      print(res);  //todo
                      //String res = "success";
                      // ignore: unrelated_type_equality_checks
                      if (res == "success") {
                        //Navigator.pushNamed(context, MainScreen.id);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MainScreen(
                              userFromlogin: _user,testt: "HELLO FROM login",
                            )));


                      }

                      // Navigator.pushNamed(context, ChatScreen.id);
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
