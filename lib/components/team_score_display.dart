import 'package:fishbowl/constants.dart';
import 'package:flutter/material.dart';

class TeamScoreDisplay extends StatelessWidget {
  final String teamName;
  final int number;
  final bool scoreByPoints;

  TeamScoreDisplay(
      {@required this.teamName,
      @required this.number,
      @required this.scoreByPoints});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 45.0),
      child: Column(
        children: <Widget>[
          Text(
            teamName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 40.0,
              fontFamily: 'VarelaRound',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            number.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 70.0,
              fontFamily: 'VarelaRound',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            scoreByPoints ? 'Points' : 'Cards',
            style: kSmallTextStyleWhite,
          ),
        ],
      ),
    );
  }
}
