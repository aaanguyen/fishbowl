import 'package:flutter/material.dart';
import 'package:fishbowl/constants.dart';

class HomeStyleButton extends StatelessWidget {
  final String label;
  final int color;
  final Function onPressed;

  HomeStyleButton(
      {@required this.label, @required this.color, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      height: 40.0,
      minWidth: 300.0,
      child: Text(
        label,
        style: kSmallTextStyleWhite,
      ),
      color: Color(color),
      onPressed: onPressed,
    );
  }
}
