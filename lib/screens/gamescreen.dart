import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/models/board.dart';
import 'package:flutter_tic_tac_toe/models/move.dart';
import 'package:flutter_tic_tac_toe/models/player.dart';
import 'package:flutter_tic_tac_toe/widgets/play_grid.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/gamescreen';
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void _showWinnerAlert(String msg) async {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over!'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.of(context).pop();
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Board boardProvider = Provider.of<Board>(context);
    if (boardProvider.winnerId != null) {}
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Tic-Tac-Toe'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<Board>(context, listen: false).reset();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: Duration(
          milliseconds: 300,
        ),
        color: boardProvider.activePlayer.color,
        child: Center(
          child: Container(
            height: 400,
            width: 400,
            child: PlayGrid(),
          ),
        ),
      ),
      // backgroundColor: theme.primaryColor,
    );
  }
}
