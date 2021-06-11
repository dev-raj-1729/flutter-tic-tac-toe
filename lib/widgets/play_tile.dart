import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/models/board.dart';
import 'package:flutter_tic_tac_toe/models/move.dart';
import 'package:provider/provider.dart';

class PlayTile extends StatelessWidget {
  final int row;
  final int col;
  PlayTile(this.row, this.col);

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<Board>(context);
    final cell = boardProvider.matrix[row][col];
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          if (boardProvider.newMove(
            Move(x: col, y: row, player: boardProvider.activePlayer),
          )) {}
        },
        style: ElevatedButton.styleFrom(
          // onSurface: Colors.red,
          onPrimary: cell.playerId != null
              ? cell.playerId == boardProvider.player1.playerId
                  ? boardProvider.player1.color
                  : boardProvider.player2.color
              : Colors.white,
          primary: Colors.white,
          alignment: Alignment.center,
          shadowColor: Colors.white,
          elevation: 10,
        ),
        child: cell.playerId != null
            ? Icon(
                cell.playerId == boardProvider.player1.playerId
                    ? boardProvider.player1.symbol
                    : boardProvider.player2.symbol,
                size: 80,
              )
            : null,
      ),
    );
  }
}
