import 'package:flutter/material.dart';

import 'board_box.dart';
import 'computer.dart';
import 'log.dart';
import 'logitem.dart';
import 'move.dart';
import 'player.dart';

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
    symbol: Icons.close_rounded,
    color: Colors.red,
  );
  late Player activePlayer;
  bool gameStart = false;
  bool gameEnd = false;
  bool showMessage = false;
  bool _computerAsPlayer2 = false;
  Player? _winner;
  late List<List<BoardBox>> _matrix;
  final Log _ls;
  Board(this._ls) {
    activePlayer = player1;
    _matrix = new List<List<BoardBox>>.generate(
      3,
      (row) => List<BoardBox>.generate(
        3,
        (col) => BoardBox(x: col, y: row, playerId: null),
      ),
    );
    notifyListeners();
  }
  List<List<BoardBox>> get matrix {
    return [..._matrix];
  }

  bool newMove(Move m) {
    if (gameEnd ||
        (_matrix[m.y][m.x].playerId != null || _winner != null) ||
        (_computerAsPlayer2 && activePlayer.playerId == player2.playerId)) {
      return false;
    }
    gameStart = true;
    _matrix[m.y][m.x].playerId = m.player.playerId;
    _checkWinner();
    _switchActivePlayer();
    notifyListeners();
    if (_computerAsPlayer2 && activePlayer.playerId == player2.playerId) {
      getMoveFromComputer();
    }
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
    _winner = null;
    activePlayer = player1;
    gameStart = false;
    gameEnd = false;
    notifyListeners();
  }

  Player? get winner {
    return _winner;
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
      _winner = tempWinner;
      gameEnd = true;
      showMessage = true;
      _addToLog();
      return;
    }
    tempWinner = checkColumn();
    if (tempWinner != null) {
      _winner = tempWinner;
      gameEnd = true;
      showMessage = true;
      _addToLog();
      return;
    }
    tempWinner = checkDiagonals();
    if (tempWinner != null) {
      _winner = tempWinner;
      gameEnd = true;
      showMessage = true;
      _addToLog();
      return;
    }
    if (checkTie()) {
      gameEnd = true;
      showMessage = true;
      _addToLog();
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

  bool checkTie() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_matrix[i][j].playerId == null) {
          return false;
        }
      }
    }
    return true;
  }

  void setComputer(bool b) {
    _computerAsPlayer2 = b;
    if (_computerAsPlayer2) {}
  }

  bool get computer {
    return _computerAsPlayer2;
  }

  List<int> toIntList() {
    return List<int>.generate(9, (index) {
      int row = index ~/ 3;
      int col = index % 3;
      if (_matrix[row][col].playerId == null) {
        return 0;
      } else if (_matrix[row][col].playerId == player1.playerId) {
        return 1;
      } else {
        return -1;
      }
    });
  }

  void getMoveFromComputer() {
    gameStart = true;
    if (gameEnd) return;
    activePlayer = player2;
    notifyListeners();
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      int move = Ai().play(toIntList(), -1);
      Move next = Move(x: move % 3, y: move ~/ 3, player: player2);
      _matrix[next.y][next.x].playerId = next.player.playerId;
      _switchActivePlayer();
      _checkWinner();
      notifyListeners();
    });
  }

  void switchPlayerSymbols() {
    var tempcol = player1.color;
    var tempsymb = player1.symbol;
    player1.color = player2.color;
    player1.symbol = player2.symbol;
    player2.color = tempcol;
    player2.symbol = tempsymb;
    notifyListeners();
  }

  void _addToLog() {
    if (winner == null && gameEnd == false) return;
    if (winner == null) {
      _ls.addItem(LogItem(
          winner: player1.playerName,
          loser: computer ? 'Computer' : player2.playerName,
          date: DateTime.now(),
          tie: true));
      return;
    }
    String winnerName = winner!.playerId == player2.playerId && computer
        ? 'Computer'
        : winner!.playerName;
    String loserName = winner!.playerId == player1.playerId
        ? computer
            ? 'Computer'
            : player2.playerName
        : player1.playerName;
    _ls.addItem(LogItem(
        winner: winnerName,
        loser: loserName,
        date: DateTime.now(),
        tie: false));
  }
}
