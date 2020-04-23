import 'package:flutter/material.dart';
import 'package:fishbowl/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';
import 'package:fishbowl/providers/data.dart';
import 'dart:async';

class InfoBar extends StatefulWidget {
  @override
  _InfoBarState createState() => _InfoBarState();
}

class _InfoBarState extends State<InfoBar> {
  int _counter = 60;
  Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          if (_counter > 0) {
            _counter--;
          } else {
            _timer.cancel();
            _counter = 60;
            Alert(
              style: kAlertStyle,
              context: context,
              type: AlertType.none,
              title: "Times up!",
              desc:
                  "It's now team ${Provider.of<Data>(context, listen: false).countingScoreForTeam1 ? '2' : '1'}'s turn.",
              content: SizedBox(height: 200),
              buttons: [
                DialogButton(
                  child: Text(
                    "START",
                    style: kSmallTextStyleWhite,
                  ),
                  onPressed: () {
                    Provider.of<Data>(context, listen: false)
                        .switchScoringTeam();
                    Navigator.pop(context);
                    _startTimer();
                  },
                  width: 250,
                )
              ],
            ).show();
          }
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'ROUND ${Provider.of<Data>(context, listen: false).currentRound}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontFamily: 'VarelaRound',
                  fontWeight: FontWeight.w700,
                  height: 0.8,
                ),
              ),
              Text(
                '# of Cards Remaining: ${Provider.of<Data>(context).cardsRemaining}',
                style: kSmallTextStyleWhite,
              ),
            ],
          ),
          Text(
            '$_counter',
            style: kBigNumberStyleWhite,
          )
        ],
      ),
    );
  }
}
