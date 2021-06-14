import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tic_tac_toe/models/board.dart';
import 'package:flutter_tic_tac_toe/models/log.dart';
import 'package:flutter_tic_tac_toe/models/logitem.dart';
import 'package:flutter_tic_tac_toe/screens/gamescreen.dart';
import 'package:flutter_tic_tac_toe/screens/homescreen.dart';
import 'package:localstore/localstore.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ls = Log(Localstore.instance);
    ls.fetchAndUpdate();
    return ChangeNotifierProvider(
      create: (context) => Board(),
      builder: (context, _) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: HomeScreen(),
        routes: <String, WidgetBuilder>{
          '/': (context) => HomeScreen(),
          GameScreen.routeName: (context) => GameScreen()
        },
      ),
    );
  }
}
