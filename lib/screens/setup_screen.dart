import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fishbowl/providers/data.dart';
import 'package:fishbowl/constants.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:fishbowl/components/home_style_button.dart';
import 'package:provider/provider.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int _pickedRounds = 3;
  int _pickedNumberOfPlayers = 6;
  String _pickedScoreMode = 'Cards';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kScaffoldAccent),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'SETUP',
                style: TextStyle(
                  fontFamily: 'VarelaRound',
                  letterSpacing: 1,
                  color: Colors.white,
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 80.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Number of rounds:',
                    style: kSetupTextStyle,
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      toggleableActiveColor: Colors.white,
                      unselectedWidgetColor: Colors.white,
                    ),
                    child: RadioButtonGroup(
                      orientation: GroupedButtonsOrientation.HORIZONTAL,
                      margin: const EdgeInsets.only(left: 12.0),
                      onSelected: (String selected) {
                        setState(() {
                          _pickedRounds = int.parse(selected);
                          Provider.of<Data>(
                            context,
                            listen: false,
                          ).updateNumberOfRounds(_pickedRounds);
                        });
                      },
                      labels: <String>[
                        "3",
                        "4",
                      ],
                      labelStyle: kSetupTextStyle,
                      picked: _pickedRounds.toString(),
                      itemBuilder: (Radio rb, Text txt, int i) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            children: <Widget>[
                              rb,
                              txt,
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Player count:',
                    style: kSetupTextStyle,
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      toggleableActiveColor: Colors.white,
                      unselectedWidgetColor: Colors.white,
                    ),
                    child: RadioButtonGroup(
                      orientation: GroupedButtonsOrientation.HORIZONTAL,
                      margin: const EdgeInsets.only(left: 12.0),
                      onSelected: (String selected) {
                        setState(() {
                          _pickedNumberOfPlayers = int.parse(selected);
                          Provider.of<Data>(
                            context,
                            listen: false,
                          ).updateNumberOfPlayers(_pickedNumberOfPlayers);
                        });
                      },
                      labels: <String>[
                        "6",
                        "8",
                        "10",
                        "12",
                      ],
                      labelStyle: kSetupTextStyle,
                      picked: _pickedNumberOfPlayers.toString(),
                      itemBuilder: (Radio rb, Text txt, int i) {
                        return Column(
                          children: <Widget>[
                            rb,
                            txt,
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Scoring Mode:',
                    style: kSetupTextStyle,
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      toggleableActiveColor: Colors.white,
                      unselectedWidgetColor: Colors.white,
                    ),
                    child: RadioButtonGroup(
                      orientation: GroupedButtonsOrientation.HORIZONTAL,
                      margin: const EdgeInsets.only(left: 12.0),
                      onSelected: (String selected) {
                        setState(() {
                          _pickedScoreMode = selected;
                          Provider.of<Data>(
                            context,
                            listen: false,
                          ).updateScoreByPoints(_pickedScoreMode);
                        });
                      },
                      labels: <String>[
                        "Cards",
                        "Points",
                      ],
                      labelStyle: kSetupTextStyle,
                      picked: _pickedScoreMode,
                      itemBuilder: (Radio rb, Text txt, int i) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            children: <Widget>[
                              rb,
                              txt,
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 70.0,
              ),
              HomeStyleButton(
                label: 'START',
                color: kHomeNewGameButtonAccent,
                onPressed: () {
                  Navigator.pushNamed(context, 'chooseScreen');
                },
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
