import 'package:tree_walker/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  OurUser user;
  final _firestore = FirebaseFirestore.instance;
  List<OurUser> list = new List();

  OurUser getOurUser() {
    return this.user;
  }

  //---- create ----
  Future<String> createUser(OurUser user) async {
    String retVal = "error";

    try {
      await _firestore.collection("users").doc(user.uid).set({
        "fullName": user.fullName,
        "email": user.email,
        "steps": user.steps,
        "treeCoins": user.treeCoins,
        "trees": user.trees
      });

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  //---- read ----
  void readUser(OurUser user) async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
          await _firestore.collection("users").doc(user.uid).get();
      print(documentSnapshot.data());
      print(documentSnapshot.data()["email"]);
    } catch (e) {
      print(e);
    }
  }

  Future<OurUser> getUser(String userID) async {
    DocumentSnapshot docSnapshot;
    try {
      docSnapshot = await _firestore.collection("users").doc(userID).get();
      OurUser user = OurUser(
          uid: userID,
          fullName: docSnapshot.data()["fullName"],
          email: docSnapshot.data()["email"],
          treeCoins: docSnapshot.data()["treeCoins"],
          steps: docSnapshot.data()["steps"],
          trees: docSnapshot.data()["trees"]);

      // user.uid = userID;
      // user.fullName = docSnapshot.data()["fullName"];
      // user.email = docSnapshot.data()["email"];
      // user.treeCoins = docSnapshot.data()["treeCoins"];
      // user.steps = docSnapshot.data()["steps"];
      // user.trees = docSnapshot.data()["trees"];

      print("******getUser from firestore*****");
      print(docSnapshot.data());
      //print(docSnapshot.data()["fullName"]);
      //print(user.email);
      //print(user);
      print("***********");

      return user;
    } catch (e) {
      print(e);
    }
  }

  void readUser1(String userID) async {
    DocumentSnapshot docSnapshot;
    try {
      docSnapshot = await _firestore.collection("users").doc(user.uid).get();
      print(docSnapshot.data());
      print(docSnapshot.data()["email"]);

      user = OurUser(
          uid: userID,
          fullName: docSnapshot.data()["fullName"],
          email: docSnapshot.data()["email"],
          treeCoins: docSnapshot.data()["treeCoins"],
          steps: docSnapshot.data()["steps"],
          trees: docSnapshot.data()["trees"]);

      // user.uid = userID;
      // user.fullName = docSnapshot.data()["fullName"];
      // user.email = docSnapshot.data()["email"];
      // user.treeCoins = docSnapshot.data()["treeCoins"];
      // user.steps = docSnapshot.data()["steps"];
      // user.trees = docSnapshot.data()["trees"];

      print("readUser1 -- ${user.fullName}");
    } catch (e) {
      print(e);
    }
  }

  Future<List<OurUser>> getTenBestUsers(int num) async{
    try {

      /*Future<QuerySnapshot> qSn = _firestore
          .collection("users")
          .orderBy("steps", descending: true)
          .limit(2)
          .get();*/

//------------ ok -----------
      Query qSn1 =  _firestore
          .collection("users")
          .orderBy("steps", descending: true)
          .limit(num);

      QuerySnapshot qSn2 = await qSn1.get();

      OurUser u;

      qSn2.docs.forEach((doc) {
        print("==== inside getTenBestUsers====");
        print(doc["fullName"]);
        print(doc.data()["email"]);
        print(doc.data()["steps"]);

        u = OurUser(
          uid: doc.id,
          fullName: doc.data()["fullName"],
          email: doc.data()["email"],
          treeCoins: doc.data()["treeCoins"],
          steps: doc.data()["steps"],
          trees: doc.data()["trees"],
        );

        list.add(u);

        print(u.fullName);
        print("***********");
        print(list);
        for (var n in list) {
          print(n.fullName);
        }
      });


///////////////////// - 1 - ////////////////////
      /*qSn.then((querySnapshot) {
        final docs = querySnapshot.docs;
        int c = 0;
            for (var doc in docs){
              c++;
              print(doc.data()["fullName"]);

              u = OurUser(
                    uid: doc.id,
                    fullName: doc.data()["fullName"],
                    email: doc.data()["email"],
                    treeCoins: doc.data()["treeCoins"],
                    steps: doc.data()["steps"],
                    trees: doc.data()["trees"],
                  );
              list.add(u);
              print(list);
             }
            print(c);
      });*/
//////////////////// - 2 - ////////////////////


      /*qSn.then((querySnapshot) {

            querySnapshot.docs.forEach((doc) {
              print("==== inside getTenBestUsers====");
              print(doc["fullName"]);
              print(doc.data()["email"]);
              print(doc.data()["steps"]);

              u = OurUser(
                uid: doc.id,
                fullName: doc.data()["fullName"],
                email: doc.data()["email"],
                treeCoins: doc.data()["treeCoins"],
                steps: doc.data()["steps"],
                trees: doc.data()["trees"],
              );

             list.add(u);

              print(u.fullName);
              print("***********");
              print(list);
              for (var n in list) {
                print(n.fullName);
              }
            });

          });*/

      //print(list);
//////////////////// - 3 - ////////////////////
      // final data = qSn.then((QuerySnapshot querySnapshot) => {
      //   querySnapshot.docs.map(
      //           (doc) =>
      //              OurUser(
      //               uid: doc.id,
      //               fullName: doc.data()["fullName"],
      //               email: doc.data()["email"],
      //               treeCoins: doc.data()["treeCoins"],
      //               steps: doc.data()["steps"],
      //               trees: doc.data()["trees"],
      //             )
      //           ).toList()
      // });

      print("******getTenBestUsers from firestore*****");
     // print(data);
      //data.then((value) => value.forEach((element) { element.forEach((e) {print(e.fullName); });}));
      print("******iiii*****");


      return list;

    } catch (e) {
      print(e);
    }
  }

  Stream<List<OurUser>> getOurUsers() {
    return _firestore.collection('users').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => OurUser.fromJson(doc.data())).toList());
  }

  //---- update ----
  void updateUserTreeCoins(OurUser user) async {
    try {
      await _firestore.collection("users").doc(user.uid).update({
        //await todo
        "treeCoins": user.treeCoins,
      });
    } catch (e) {
      print(e);
    }
  }

  //updateUserTrees  //todo
  void updateUserTrees(OurUser user) async {
    try {
      await _firestore.collection("users").doc(user.uid).update({
        //await todo
        "trees": user.trees,
      });
    } catch (e) {
      print(e);
    }
  }

  //updateUserSteps  //todo
  void updateUserSteps(OurUser user) async {
    try {
      await _firestore.collection("users").doc(user.uid).update({
        //await todo
        "steps": user.steps,
      });
    } catch (e) {
      print(e);
    }
  }

  //---- delete ----
  void deleteUser(OurUser user) async {
    try {
      await _firestore.collection("users").doc(user.uid).delete(); //await todo

    } catch (e) {
      print(e);
    }
  }

//---- get 5 best users ----
// Stream<OurUser>
// Stream<List<OurUser>> getUsers(){
//
// }

}
