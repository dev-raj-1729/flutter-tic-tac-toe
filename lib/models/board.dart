import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/models/board_box.dart';
import 'package:flutter_tic_tac_toe/models/move.dart';
import 'package:flutter_tic_tac_toe/models/player.dart';

class Board with ChangeNotifier {
  Player player1 = Player(
    playerId: 1,
    playerName: "Player 1",
    symbol: Icons.circle_outlined,
    color: Colors.green,
  );
  Player player2 = Player(
    playerId: 2,
    playerName: "Player 2",
    symbol: Icons.close,
    color: Colors.red,
  );
  late Player activePlayer;
  bool gameStart = false;
  bool gameEnd = false;
  int? _winnerId;
  late List<List<BoardBox>> _matrix;
  Board() {
    activePlayer = player1;
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
    if (_matrix[m.y][m.x].playerId != null || winnerId != null) {
      return false;
    }
    _matrix[m.y][m.x].playerId = m.player.playerId;
    print('this works');
    _checkWinner();
    _switchActivePlayer();
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
    _winnerId = null;
    activePlayer = player1;
    notifyListeners();
  }

  int? get winnerId {
    return _winnerId;
  }

  void _switchActivePlayer() {
    if (activePlayer.playerId == player1.playerId) {
      activePlayer = player2;
    } else {
      activePlayer = player1;
    }
  }

  void _checkWinner() {
    bool threeFull = true;
    for (int i = 0; i < 3; i++) {
      threeFull = true;
      for (int j = 1; j < 3; j++) {
        if (_matrix[i][j].playerId != _matrix[i][j - 1].playerId ||
            _matrix[i][j].playerId == null) {
          threeFull = false;
        }
      }
      if (threeFull) {
        _winnerId = _matrix[i][0].playerId;
      }
    }
    for (int i = 0; i < 3; i++) {
      threeFull = true;
      for (int j = 1; j < 3; j++) {
        if (_matrix[j][i].playerId != _matrix[j - 1][i].playerId ||
            _matrix[j][i].playerId == null) {
          threeFull = false;
        }
      }
      if (threeFull) {
        _winnerId = _matrix[i][0].playerId;
      }
    }
    threeFull = true;
    for (int i = 1; i < 3; i++) {
      if (_matrix[i][i].playerId != _matrix[i - 1][i - 1].playerId ||
          _matrix[i][i].playerId == null) {
        threeFull = false;
      }
    }
    if (threeFull) {
      _winnerId = _matrix[0][0].playerId;
    }
    threeFull = true;
    for (int i = 1; i < 3; i++) {
      if (_matrix[i][2 - i].playerId != _matrix[i - 1][3 - i].playerId ||
          _matrix[i][2 - i].playerId == null) {
        threeFull = false;
      }
    }
  }
}
