import 'package:fishbowl/constants.dart';
import 'package:flutter/material.dart';
import 'package:fishbowl/components/playmat/playmat.dart';

class PlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    Provider.of<Data>(context, listen: false).updateCardsRemaining(
//        Provider.of<Data>(context, listen: false).deckSize);
//    final List<Map<String, dynamic>> playingDeck =
//        Provider.of<Data>(context, listen: false).playingDeck;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(kScaffoldAccent),
        body: SafeArea(
          child: PlayMat(),
        ),
      ),
    );
  }
}
