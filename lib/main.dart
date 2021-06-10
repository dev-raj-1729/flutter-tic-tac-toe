import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/screens/gamescreen.dart';
import 'package:flutter_tic_tac_toe/screens/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: HomeScreen(),
      routes: <String, WidgetBuilder>{
        '/': (context) => HomeScreen(),
        GameScreen.routeName: (context) => GameScreen()
      },
    );
  }
}
