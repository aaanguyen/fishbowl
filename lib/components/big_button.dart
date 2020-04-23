import 'package:flutter/material.dart';
import 'package:fishbowl/constants.dart';

class BigButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  BigButton({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      height: 60.0,
      minWidth: double.infinity,
      child: Text(
        text,
        style: kSmallTextStyleWhite,
      ),
      color: Color(0xff64dd17),
      onPressed: onPressed,
    );
  }
}
