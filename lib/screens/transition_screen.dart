import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fishbowl/providers/data.dart';
import 'package:fishbowl/constants.dart';
import 'package:fishbowl/components/team_score_display.dart';
import 'package:fishbowl/components/big_button.dart';

const textBodies = [
  'Do or say anything!',
  'Use one word only!',
  'Just charades!',
  'House rules!'
];

class TransitionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(kScaffoldAccent),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  (Provider.of<Data>(context, listen: false).currentRound <=
                          Provider.of<Data>(context, listen: false)
                              .numberOfRounds)
                      ? Text(
                          'ROUND ${Provider.of<Data>(context).currentRound}',
                          style: kTransitionHeaderTextStyle,
                        )
                      : Text('GAME OVER', style: kTransitionGameOverTextStyle),
                  Text(
                    (Provider.of<Data>(context, listen: false).currentRound <=
                            Provider.of<Data>(context, listen: false)
                                .numberOfRounds)
                        ? textBodies[
                            Provider.of<Data>(context).currentRound - 1]
                        : (Provider.of<Data>(context, listen: false)
                                    .team1Score >
                                Provider.of<Data>(context, listen: false)
                                    .team2Score)
                            ? 'Team 1 wins!!'
                            : (Provider.of<Data>(context, listen: false)
                                        .team1Score <
                                    Provider.of<Data>(context, listen: false)
                                        .team2Score)
                                ? 'Team 2 wins!!'
                                : 'Tie game!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontFamily: 'VarelaRound',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TeamScoreDisplay(
                        teamName: 'Team 1',
                        number: Provider.of<Data>(context).team1Score,
                        scoreByPoints: Provider.of<Data>(context, listen: false)
                            .scoreByPoints,
                      ),
                      TeamScoreDisplay(
                        teamName: 'Team 2',
                        number: Provider.of<Data>(context).team2Score,
                        scoreByPoints: Provider.of<Data>(context, listen: false)
                            .scoreByPoints,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: BigButton(
                      text: (Provider.of<Data>(context, listen: false)
                                  .currentRound <=
                              Provider.of<Data>(context, listen: false)
                                  .numberOfRounds)
                          ? 'START ROUND'
                          : 'HOME',
                      onPressed: () {
                        if (Provider.of<Data>(context, listen: false)
                                .currentRound <=
                            Provider.of<Data>(context, listen: false)
                                .numberOfRounds) {
                          Provider.of<Data>(context, listen: false)
                              .decideStartingTeam();
//                    Navigator.pushNamedAndRemoveUntil(
//                      context,
//                      'playScreen',
//                      ModalRoute.withName('homeScreen'),
//                    );
                          Navigator.pushNamed(context, 'playScreen');
                        } else {
                          Provider.of<Data>(context, listen: false)
                              .resetGameState();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
