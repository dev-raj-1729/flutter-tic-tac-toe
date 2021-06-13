import 'package:flutter/material.dart';
// import 'package:flutter_tic_tac_toe/models/board.dart';
import 'package:flutter_tic_tac_toe/widgets/play_tile.dart';
// import 'package:provider/provider.dart';

class PlayGrid extends StatelessWidget {
  final double boardSide;
  PlayGrid(this.boardSide);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        final row = index ~/ 3;
        final col = index % 3;
        return PlayTile(row, col, boardSide);
      },
      itemCount: 9,
    );
  }
}
