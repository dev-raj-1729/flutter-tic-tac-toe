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
  bool _computerAsPlayer2 = false;
  Player? _winnerId;
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
    if (_matrix[m.y][m.x].playerId != null || _winnerId != null) {
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

  Player? get winner {
    return _winnerId;
  }

  void _switchActivePlayer() {
    if (activePlayer.playerId == player1.playerId) {
      activePlayer = player2;
    } else {
      activePlayer = player1;
    }
  }

  Player? getPlayerFromId(int? playerId) {
    return player1.playerId == playerId
        ? player1
        : player2.playerId == playerId
            ? player2
            : null;
  }

  void _checkWinner() {
    var tempWinner = checkRow();
    if (tempWinner != null) {
      _winnerId = tempWinner;
      return;
    }
    tempWinner = checkColumn();
    if (tempWinner != null) {
      _winnerId = tempWinner;
      return;
    }
    tempWinner = checkDiagonals();
    if (tempWinner != null) {
      _winnerId = tempWinner;
      return;
    }
  }

  Player? checkRow() {
    int player1Count = 0;
    int player2Count = 0;
    for (int i = 0; i < 3; i++) {
      player2Count = player1Count = 0;
      for (int j = 0; j < 3; j++) {
        if (_matrix[i][j].playerId == player1.playerId) {
          player1Count++;
        } else if (_matrix[i][j].playerId == player2.playerId) {
          player2Count++;
        }
      }
      if (player1Count == 3) {
        return player1;
      } else if (player2Count == 3) {
        return player2;
      }
    }
    return null;
  }

  Player? checkColumn() {
    int player1Count = 0;
    int player2Count = 0;
    for (int i = 0; i < 3; i++) {
      player1Count = player2Count = 0;
      for (int j = 0; j < 3; j++) {
        if (_matrix[j][i].playerId == player1.playerId) {
          player1Count++;
        } else if (_matrix[j][i].playerId == player2.playerId) {
          player2Count++;
        }
      }
      if (player1Count == 3) {
        return player1;
      } else if (player2Count == 3) {
        return player2;
      }
    }
    return null;
  }

  Player? checkDiagonals() {
    int player1Count = 0;
    int player2Count = 0;
    for (int i = 0; i < 3; i++) {
      if (_matrix[i][i].playerId == player1.playerId) {
        player1Count++;
      } else if (_matrix[i][i].playerId == player2.playerId) {
        player2Count++;
      }
    }
    if (player1Count == 3) {
      return player1;
    } else if (player2Count == 3) {
      return player2;
    }
    player1Count = 0;
    player2Count = 0;
    for (int i = 0; i < 3; i++) {
      if (_matrix[2 - i][i].playerId == player1.playerId) {
        player1Count++;
      } else if (_matrix[2 - i][i].playerId == player2.playerId) {
        player2Count++;
      }
    }
    if (player1Count == 3) {
      return player1;
    } else if (player2Count == 3) {
      return player2;
    }
    return null;
  }

  void setComputer(bool b) {
    _computerAsPlayer2 = b;
  }

  bool get computer {
    return _computerAsPlayer2;
  }
}
