import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstore/localstore.dart';
import 'package:provider/provider.dart';

import 'models/board.dart';
import 'models/log.dart';
import 'screens/gamescreen.dart';
import 'screens/homescreen.dart';
import 'screens/logscreen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Board>(create: (context) => Board(ls)),
        ChangeNotifierProvider.value(value: ls),
      ],
      builder: (context, _) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: <String, WidgetBuilder>{
          '/': (context) => HomeScreen(),
          GameScreen.routeName: (context) => GameScreen(),
          LogScreen.routeName: (context) => LogScreen(),
        },
      ),
    );
  }
}
