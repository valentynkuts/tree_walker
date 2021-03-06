import 'package:flutter/material.dart';
import 'package:tree_walker/components/rounded_button.dart';
import 'package:tree_walker/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tree_walker/models/user.dart';
import 'package:tree_walker/screens/main_screen.dart';
import 'package:tree_walker/services/firestore_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  OurUser ourUserLogin;
  FirestoreService db = FirestoreService();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  Future<void> getOurUser() async {
    final loggedInUser = _auth.currentUser;
    ourUserLogin = await db.getUser(loggedInUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
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
                    child: Image.asset('images/tree4.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
                cursorColor: Colors.white,
                // enter email
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
                obscureText: true,
                //for password
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
                cursorColor: Colors.white,
                // enter password
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'log in',
                colour: Colors.teal[800],
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    //check email, password and return 'user'
                    final userL = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    //if ok redirect to main screen
                    if (userL != null) {
                      await getOurUser();

                      if (ourUserLogin != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen(
                                      userMain: ourUserLogin,
                                      testt: "HELLO FROM login",
                                    )));
                      }
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
