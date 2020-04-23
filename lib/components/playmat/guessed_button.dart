import 'package:flutter/material.dart';
import 'package:fishbowl/components/big_button.dart';

class GuessedButton extends StatelessWidget {
  final Function onPressed;

  GuessedButton({@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25.0),
      child: BigButton(
        text: 'Got it!',
        onPressed: onPressed,
      ),
    );
  }
}
