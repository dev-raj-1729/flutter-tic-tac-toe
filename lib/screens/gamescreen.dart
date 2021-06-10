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
  Player player1 = Player(
    playerId: 1,
    playerName: "Player 1",
    symbol: Icon(
      Icons.circle_outlined,
      size: 80,
    ),
    color: Colors.blue,
  );
  Player player2 = Player(
    playerId: 2,
    playerName: "Player 2",
    symbol: Icon(
      Icons.close,
      size: 80,
    ),
    color: Colors.red,
  );
  late bool activePlayer1;
  bool gameStart = false;
  bool gameEnd = false;
  @override
  void initState() {
    super.initState();
    activePlayer1 = true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
      body: Center(
        child: Container(
          height: 400,
          width: 400,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              final row = index ~/ 3;
              final col = index % 3;
              final cell = boardProvider.matrix[row][col];
              return Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    if (boardProvider.newMove(
                      Move(
                          x: col,
                          y: row,
                          player: activePlayer1 ? player1 : player2),
                    )) {
                      activePlayer1 = !activePlayer1;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    // onSurface: Colors.red,
                    onPrimary: cell.playerId != null
                        ? cell.playerId == player1.playerId
                            ? player1.color
                            : player2.color
                        : Colors.white,
                    primary: Colors.white,
                    alignment: Alignment.center,
                  ),
                  child: cell.playerId != null
                      ? cell.playerId == player1.playerId
                          ? player1.symbol
                          : player2.symbol
                      : null,
                ),
              );
            },
            itemCount: 9,
          ),
        ),
      ),
      backgroundColor: theme.primaryColor,
    );
  }
}
