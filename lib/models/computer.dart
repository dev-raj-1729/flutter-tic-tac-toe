import 'package:flutter_tic_tac_toe/models/move.dart';
import 'package:flutter_tic_tac_toe/models/player.dart';

class Computer {
  static Move nextMove(List<List<int>> board, Player player) {
    // for (int i=0;i<3;i++){
    //   for (int j=0;j<3;j++) {
    //     if(board)
    //   }
    // }
    print(board);
    return Move(x: 0, y: 0, player: player);
  }
}
