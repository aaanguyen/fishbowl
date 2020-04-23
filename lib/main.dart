import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/loading_screen.dart';
import 'screens/home_screen.dart';
import 'screens/setup_screen.dart';
import 'screens/choose_screen.dart';
import 'screens/play_screen.dart';
import 'screens/transition_screen.dart';
import 'constants.dart';
import 'package:provider/provider.dart';
import 'providers/data.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(kScaffoldAccent),
    statusBarColor: Color(kScaffoldAccent),
  ));
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('images/fishbowl.png'), context);
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'loadingScreen',
        routes: {
          'loadingScreen': (context) => LoadingScreen(),
          'homeScreen': (context) => HomeScreen(),
          'setupScreen': (context) => SetupScreen(),
          'chooseScreen': (context) => ChooseScreen(),
          'playScreen': (context) => PlayScreen(),
          'transitionScreen': (context) => TransitionScreen(),
        },
      ),
    );
  }
}
