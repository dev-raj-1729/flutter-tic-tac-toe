import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/models/board.dart';
import 'package:flutter_tic_tac_toe/widgets/play_form.dart';
import 'package:flutter_tic_tac_toe/widgets/play_grid.dart';
import 'package:provider/provider.dart';
import 'dart:math';

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
    final mediaQuery = MediaQuery.of(context);
    Board boardProvider = Provider.of<Board>(context);
    final double boardSide = min(
        600, min(mediaQuery.size.width * 0.90, mediaQuery.size.height * 0.6));
    final double animatedBarOffset = ((mediaQuery.size.width - 200) / 6) * 0.90;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60 * boardSide / 400),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('Tic-Tac-Toe'),
          actions: [
            if (boardProvider.computer && !boardProvider.gameStart)
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {
                  boardProvider.getMoveFromComputer();
                },
              ),
            IconButton(
              onPressed: () {
                Provider.of<Board>(context, listen: false).reset();
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: AnimatedContainer(
          height: mediaQuery.size.height -
              mediaQuery.padding.top -
              mediaQuery.padding.bottom,
          duration: Duration(
            milliseconds: 400,
          ),
          color: boardProvider.activePlayer.color[800],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 30,
                alignment: Alignment.topCenter,
                child: boardProvider.gameEnd
                    ? Text(
                        boardProvider.winner != null
                            ? "${boardProvider.winner!.playerName} wins!"
                            : "It's a Tie!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    : null,
              ),
              Center(
                child: Container(
                  height: boardSide,
                  width: boardSide,
                  child: PlayGrid(boardSide),
                ),
              ),
              SizedBox(
                height: 20 * boardSide / 400,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                color: boardProvider.activePlayer.color[900],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => PlayForm(boardProvider.player1),
                        );
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            boardProvider.player1.symbol,
                            color: boardProvider.player1.color,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(boardProvider.player1.playerName),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<Board>(context, listen: false)
                            .switchPlayerSymbols();
                      },
                      icon: Icon(
                        Icons.swap_horiz_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            boardProvider.player2.symbol,
                            color: boardProvider.player2.color,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(boardProvider.computer
                              ? 'Computer'
                              : boardProvider.player2.playerName),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              AnimatedContainer(
                padding: EdgeInsets.only(
                    left: animatedBarOffset * 1.05, right: animatedBarOffset),
                duration: Duration(milliseconds: 400),
                child: Container(
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                alignment: boardProvider.activePlayer.playerId ==
                        boardProvider.player1.playerId
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
              )
            ],
          ),
        ),
      ),
    );
  }
}
