import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _fs = FirebaseFirestore.instance;
final _auth1 = FirebaseAuth.instance;

Future<void> userSetup(String userName) async{

  //CollectionReference users = FirebaseFirestore.instance.collection('Users');
  //FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference users = _fs.collection('Users');
  String uid = _auth1.currentUser.uid.toString();

  users.add({
    'username': userName,
    'uid':uid
  });

  return;

}


//AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
//FirebaseUser user = result.user
//await Firestore.instance.collection('users').document(user.uid).setData({ 'firstName': _firstName'})