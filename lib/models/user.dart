
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

  int getSteps() {
    return this.steps;
  }

  int getTreeCoins() {
    return this.treeCoins;
  }

  factory OurUser.fromJson(Map<String, dynamic> json) {
    return OurUser(
      email: json['email'],
      fullName: json['fullName'],
      steps: json['steps'],
      treeCoins: json['treeCoins'],
      trees: json['trees'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'fullName': fullName,
      'steps': steps,
      'treeCoins': treeCoins,
      'trees': trees
    };
  }
}
