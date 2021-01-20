import 'package:flutter/material.dart';
import '../constants.dart';

class IconContent extends StatelessWidget {

  final IconData icon;
  final String label;

  IconContent({this.icon,this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          //FontAwesomeIcons.mars,
          icon,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          //'MALE',
          label,
          style: kLabelTextStyle,
        )
      ],
    );
  }
}
