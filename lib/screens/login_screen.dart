import 'package:flutter/material.dart';
import 'package:tree_walker/components/rounded_button.dart';
import 'package:tree_walker/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tree_walker/models/user.dart';
import 'package:tree_walker/screens/main_screen.dart';
import 'package:tree_walker/screens/pedometer_screen.dart';
import 'package:tree_walker/services/firestore_service.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


//OurUser ourUser;
//final db = FirestoreService();
//final _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  OurUser ourUser;
  FirestoreService db = FirestoreService();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;


  Future<void> getOurUser() async {
    //final _auth = FirebaseAuth.instance;  /////// todo
    final loggedInUser = _auth.currentUser;
    //final db = FirestoreService();  ////// todo
    ourUser = await db.getUser(loggedInUser.uid);  //get OurUser

    print("----getOurUser from login---");
    print(ourUser.email);
    print("------------------");

  }

  //----------------

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
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                // enter email
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email'
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true, //for password
                textAlign: TextAlign.center,
                // enter password
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'log in',
                colour: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    //check email, password and return 'user'
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    //if ok redirect to main screen
                    if (user != null) {
                      print(user.user.uid);
                      print(user.user.email);


                      print("==== OurUser from middle====");
                      await getOurUser();
                     // print(ourUser.steps);
                      print("==================");

                      if(ourUser != null){
                        print("### not null ####");
                        print(ourUser.email);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MainScreen(
                              userFromlogin: ourUser, testt: "HELLO FROM login",
                            )));
                        print("#######");
                      }

                      //Navigator.pushNamed(context, MainScreen.id);
                      //Navigator.pushNamed(context, ChatScreen.id);
                      //Navigator.pushNamed(context, PedometerScreen.id);

                    }
                    setState(() {
                      showSpinner = false;
                    });
                  }
                  catch(e){
                    print(e);
                    print("%%%%%%%%%%%%%%%");
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
