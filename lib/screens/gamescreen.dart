import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/models/board.dart';
// import 'package:flutter_tic_tac_toe/models/move.dart';
// import 'package:flutter_tic_tac_toe/models/player.dart';
import 'package:flutter_tic_tac_toe/widgets/play_grid.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/gamescreen';
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // void _showWinnerAlert(String msg) async {
  //   return showDialog<void>(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Game Over!'),
  //       content: Text(msg),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             // Navigator.of(context).pop();
  //           },
  //           child: Text("Ok"),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    Board boardProvider = Provider.of<Board>(context);
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
          milliseconds: 400,
        ),
        color: boardProvider.activePlayer.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              color: Colors.red,
              child: Text(boardProvider.winner != null
                  ? boardProvider.winner!.playerName
                  : ""),
            ),
            Center(
              child: Container(
                height: 400,
                width: 400,
                child: PlayGrid(),
              ),
            ),
            Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(boardProvider.player1.playerName),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Text(boardProvider.player2.playerName),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      // backgroundColor: theme.primaryColor,
    );
  }
}
