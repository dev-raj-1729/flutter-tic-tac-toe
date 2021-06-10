import 'package:flutter/cupertino.dart';
import 'package:flutter_tic_tac_toe/models/board_box.dart';
import 'package:flutter_tic_tac_toe/models/move.dart';

class Board with ChangeNotifier {
  late List<List<BoardBox>> _matrix;
  Board() {
    _matrix = new List<List<BoardBox>>.generate(
      3,
      (row) => List<BoardBox>.generate(
        3,
        (col) => BoardBox(x: col, y: row, playerId: null),
      ),
    );
    notifyListeners();
    // print(_matrix);
  }
  List<List<BoardBox>> get matrix {
    return [..._matrix];
  }

  bool newMove(Move m) {
    if (_matrix[m.y][m.x].playerId != null) {
      return false;
    }
    _matrix[m.y][m.x].playerId = m.player.playerId;
    print('this works');
    notifyListeners();
    return true;
  }

  void reset() {
    _matrix = new List<List<BoardBox>>.generate(
      3,
      (row) => List<BoardBox>.generate(
        3,
        (col) => BoardBox(x: col, y: row, playerId: null),
      ),
    );
    notifyListeners();
  }
}
