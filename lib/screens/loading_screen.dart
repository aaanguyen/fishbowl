import 'package:fishbowl/constants.dart';
import 'package:flutter/material.dart';
import 'package:fishbowl/resources/db_provider.dart';
import 'package:provider/provider.dart';
import 'package:fishbowl/providers/data.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    loadActiveCardMaps();
  }

  void loadActiveCardMaps() async {
    DbProvider dbProvider = DbProvider();
//    await dbProvider.deleteDb();
    await dbProvider.init();
    List<Map<String, dynamic>> cardMaps =
        await dbProvider.fetchActiveCardMaps();
    Provider.of<Data>(
      context,
      listen: false,
    ).updateActiveCardSet(List<Map<String, dynamic>>.from(cardMaps));
    Navigator.pushNamed(context, 'homeScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kScaffoldAccent),
      body: SafeArea(
        child: Center(
          child: Hero(
            tag: 'logo',
            child: Image.asset(
              'images/fishbowl.png',
              width: 75,
              height: 75,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
    ;
  }
}
