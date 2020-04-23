import 'package:flutter/material.dart';
import 'package:fishbowl/constants.dart';
import 'package:fishbowl/components/home_style_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(kScaffoldAccent),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'images/fishbowl.png',
                        width: 75,
                        height: 75,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      child: Text(
                        'FISHBOWL',
                        style: TextStyle(
                          fontFamily: 'VarelaRound',
                          letterSpacing: 1,
                          color: Colors.white,
                          fontSize: 35.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: HomeStyleButton(
                        label: 'NEW GAME',
                        color: kHomeNewGameButtonAccent,
                        onPressed: () {
                          Navigator.pushNamed(context, 'setupScreen');
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: HomeStyleButton(
                        label: 'HOW TO PLAY',
                        color: kHomeHowToPlayButtonAccent,
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: HomeStyleButton(
                        label: 'OPTIONS',
                        color: kHomeOptionsButtonAccent,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
