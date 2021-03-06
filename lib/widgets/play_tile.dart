import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/board.dart';
import '../models/move.dart';

class PlayTile extends StatelessWidget {
  final int row;
  final int col;
  final double boardSide;
  PlayTile(this.row, this.col, this.boardSide);

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<Board>(context);
    final cell = boardProvider.matrix[row][col];
    return Container(
      margin: EdgeInsets.all(10 * (boardSide / 400)),
      child: ElevatedButton(
        onPressed: () {
          boardProvider.newMove(
            Move(x: col, y: row, player: boardProvider.activePlayer),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: cell.playerId != null
              ? cell.playerId == boardProvider.player1.playerId
                  ? boardProvider.player1.color
                  : boardProvider.player2.color
              : Colors.white,
          onPrimary: Colors.white,
          alignment: Alignment.center,
          shadowColor: Colors.black,
          elevation: 10 * (boardSide / 400),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: cell.playerId != null
            ? Icon(
                cell.playerId == boardProvider.player1.playerId
                    ? boardProvider.player1.symbol
                    : boardProvider.player2.symbol,
                size: 80 * (boardSide * 0.7 / 400),
              )
            : null,
      ),
    );
  }
}
