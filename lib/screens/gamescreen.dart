import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/models/board.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/gamescreen';
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var board = Board();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('GameScreen'),
      ),
      backgroundColor: theme.primaryColor,
    );
  }
}
