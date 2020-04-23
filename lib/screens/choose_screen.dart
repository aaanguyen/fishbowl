import 'package:fishbowl/components/big_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fishbowl/constants.dart';
import 'package:fishbowl/providers/data.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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

List<List<Map<String, dynamic>>> partition(
    List<Map<String, dynamic>> cardMaps, int partitionSize) {
  List<List<Map<String, dynamic>>> partitions = [];
  for (int i = 0; i < cardMaps.length; i += partitionSize) {
    partitions.add(cardMaps.sublist(i, i + partitionSize));
  }
  return partitions;
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

class ChooseScreen extends StatefulWidget {
  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  List<Map<String, dynamic>> playingDeck;
  List<Map<String, dynamic>> randomlyDrawnCards;
  List<List<Map<String, dynamic>>> packets;
  int numberOfPlayers;
  int deckSize;
  int packetSize;
  int selectedPacketSize;
  int currentChooser;
  int numberOfCardsToDraw;
  int numberOfSelectionsLeft;

  @override
  void initState() {
    super.initState();
    playingDeck = [];
    numberOfPlayers =
        Provider.of<Data>(context, listen: false).numberOfPlayers; //6
    deckSize = Provider.of<Data>(context, listen: false).deckSize; //42
    selectedPacketSize = deckSize ~/ numberOfPlayers; //7
    packetSize = (selectedPacketSize + 3).toInt(); //10
    currentChooser = 0;
    numberOfCardsToDraw = packetSize * numberOfPlayers; //60
    randomlyDrawnCards = Provider.of<Data>(context, listen: false)
        .getRandomCardMaps(numberOfCardsToDraw);
    packets = partition(randomlyDrawnCards, packetSize);
    numberOfSelectionsLeft = selectedPacketSize;
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kScaffoldAccent),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Pick $numberOfSelectionsLeft more card${numberOfSelectionsLeft != 1 ? 's' : ''}!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontFamily: 'VarelaRound',
                        fontWeight: FontWeight.w700,
                        height: 0.8,
                      ),
                    ),
                    Text(
                      '# of Cards Picked: ${playingDeck.length}/$deckSize',
                      style: kSmallTextStyleWhite,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              CarouselSlider(
//                height: 520.0,
                enableInfiniteScroll: false,
                viewportFraction: 0.9,
                aspectRatio: 3 / 4,
                onPageChanged: (i) {
                  index = i;
                },
                initialPage: index,
                items: packets[currentChooser].map((obj) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Material(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.0),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                              color:
                                                  getPointsAccent(obj['value']),
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
                                              color:
                                                  getPointsAccent(obj['value']),
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
                                                        fontFamily:
                                                            'VarelaRound',
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                                      fontWeight:
                                                          FontWeight.w800,
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
                                ))),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: BigButton(
                  text: 'CHOOSE',
                  onPressed: () {
                    setState(() {
                      playingDeck.add(packets[currentChooser][index]);
                      packets[currentChooser].removeAt(index);
//                      if (index > packets[currentChooser].length - 1) {
//                        index = 0;
//                      }
                      numberOfSelectionsLeft--;
                      print('decksize is ${playingDeck.length}');
                      if (numberOfSelectionsLeft == 0) {
                        if (currentChooser < numberOfPlayers - 1) {
                          Alert(
                            style: kAlertStyle,
                            context: context,
                            type: AlertType.none,
                            title: "You're done!",
                            desc: "Next person's turn to pick cards.",
                            content: SizedBox(height: 200),
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "START PICKING",
                                  style: kSmallTextStyleWhite,
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 250,
                              )
                            ],
                          ).show();
                        }
                        numberOfSelectionsLeft = selectedPacketSize;
                        currentChooser++;
                        if (currentChooser == numberOfPlayers) {
                          currentChooser--;
                          playingDeck.shuffle();
                          Provider.of<Data>(context, listen: false)
                              .updatePlayingDeck(playingDeck);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'transitionScreen',
                            ModalRoute.withName('homeScreen'),
                          );
                        }
                      }
//                      for (var obj in playingDeck) {
//                        print(obj['name']);
//                      }
//                      print('');
//                      print('the pile looks like:');
//                      for (var obj in packets[currentChooser]) {
//                        print(obj['name']);
//                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
