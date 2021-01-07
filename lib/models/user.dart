import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  String uid;
  String email;
  String fullName;
  int steps;
  int treeCoins;
  int trees;

  OurUser(
      {this.uid,
      this.email,
      this.fullName,
      this.steps,
      this.treeCoins,
      this.trees});
}
