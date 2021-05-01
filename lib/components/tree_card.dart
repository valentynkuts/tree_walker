import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tree_walker/components/rounded_button.dart';

class TreeCard extends StatelessWidget {
  final String image;
  final String treeName;
  final String price;
  final Function onPress;

  TreeCard({@required this.image, this.treeName, this.price, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 50.0,
            backgroundImage: AssetImage(image),
          ),
          Text(
            treeName,
            style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 30.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 25.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.5,
            ),
          ),
          SizedBox(
            height: 20.0,
            width: 50.0,
            child: Divider(
              color: Colors.teal.shade100,
            ),
          ),
          RoundedButton(
            title: 'buy',
            colour: Colors.teal[300],
            onPressed: onPress,
          ),
          SizedBox(
            height: 20.0,
            width: 300.0,
            child: Divider(
              color: Colors.teal.shade100,
            ),
          ),
        ],
      ),
    );
  }
}
