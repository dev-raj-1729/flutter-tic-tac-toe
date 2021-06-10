import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/models/board.dart';
import 'package:flutter_tic_tac_toe/models/move.dart';
import 'package:flutter_tic_tac_toe/models/player.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/gamescreen';
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Board board = Board();
  Player player1 = Player(
    playerId: 1,
    playerName: "dev",
    symbol: Icon(Icons.circle),
  );
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider<Board>.value(
      value: board,
      builder: (context, _) {
        Board board = Provider.of<Board>(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_sharp),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Center(
            child: Container(
              color: Colors.red,
              height: 400,
              width: 400,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) => ElevatedButton(
                  onPressed: () {
                    board.newMove(
                        Move(x: index % 3, y: index ~/ 3, player: player1));
                  },
                  style: ElevatedButton.styleFrom(
                    // onSurface: Colors.red,
                    onPrimary: theme.primaryColor,
                    primary: Colors.white,
                  ),
                  child: Text(
                      (board.matrix[index ~/ 3][index % 3].playerId ?? 0)
                          .toString()),
                ),
                itemCount: 9,
              ),
            ),
          ),
          backgroundColor: theme.primaryColor,
        );
      },
    );
  }
}
