import 'package:flutter/material.dart';
import 'package:fishbowl/components/playmat/info_bar.dart';
import 'package:fishbowl/components/playmat/play_stack.dart';
import 'package:provider/provider.dart';
import 'package:fishbowl/providers/data.dart';
import 'package:fishbowl/constants.dart';
import 'package:fishbowl/components/playmat/guessed_button.dart';

Color getPointsAccent(int value) {
  if (value == 1) {
    return Color(k1PointAccent);
  } else if (value == 2) {
    return Color(k2PointAccent);
  } else if (value == 3) {
    return Color(k3PointAccent);
  } else {
    return Color(k4PointAccent);
  }
}

List<Widget> getCircleGroupBorder() {
  List<Widget> list = [];
  for (int i = 0; i < 13; i++) {
    list.add(
      Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        width: 7.0,
        height: 7.0,
      ),
    );
    if (i < 12) {
      list.add(
        SizedBox(width: 2.5),
      );
    }
  }
  return list;
}

class PlayMat extends StatelessWidget {
  final GlobalKey<PlayStackState> _playStackState = GlobalKey<PlayStackState>();

  void onGuessedButtonPressed() {
    _playStackState.currentState.cardGuessed();
  }

  @override
  Widget build(BuildContext context) {
    PlayStack playStack = PlayStack(
      key: _playStackState,
      padding: EdgeInsets.fromLTRB(25, 30, 25, 10),
      children: Provider.of<Data>(context, listen: false)
          .playingDeck
          .map((Map<String, dynamic> obj) {
        return Swipable(
            object: obj,
            builder: (SwiperPosition position, double progress) {
              return Material(
                  elevation: 4,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 150.0,
                            width: 280.0,
                            child: Center(
                              child: Text(
                                obj['name'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  height: 1.03,
                                  fontSize: 35,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 220,
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              obj['body'],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Varela',
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: getCircleGroupBorder(),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  obj['category'],
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: 'VarelaRound',
                                    fontWeight: FontWeight.w700,
                                    color: getPointsAccent(obj['value']),
                                    letterSpacing: 2.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 25.0,
                                ),
                                Container(
                                  height: 75,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: getPointsAccent(obj['value']),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(60.0),
                                      topRight: Radius.circular(60.0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Text(
                                          obj['value'].toString(),
                                          style: TextStyle(
                                              height: 0.8,
                                              fontFamily: 'VarelaRound',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 35.0,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          obj['value'] == 1
                                              ? 'POINT'
                                              : 'POINTS',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'Nunito',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 1.8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )));
            });
      }).toList(),
      visibleCount: 2,
      translationInterval: 6,
      scaleInterval: 0.01,
      onEnd: () {
//        Navigator.pushNamedAndRemoveUntil(
//          context,
//          'transitionScreen',
//          ModalRoute.withName('homeScreen'),
//        );
        Provider.of<Data>(context, listen: false).shufflePlayingDeck();
        Navigator.pop(context);
      },
      onSwipe: (int index, SwiperPosition position) =>
          debugPrint("onSwipe $index $position"),
      onRewind: (int index, SwiperPosition position) =>
          debugPrint("onRewind $index $position"),
    );
    return Column(
      children: <Widget>[
        Expanded(flex: 3, child: InfoBar()),
        Expanded(
          flex: 18,
          child: playStack,
        ),
        Expanded(
          flex: 4,
          child: GuessedButton(onPressed: () {
            onGuessedButtonPressed();
          }),
        ),
      ],
    );
  }
}
