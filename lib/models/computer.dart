import 'package:flutter_tic_tac_toe/models/move.dart';
import 'package:flutter_tic_tac_toe/models/player.dart';
import 'dart:math';

class Computer {
  static late Player player;
  static late Player opponent;
  static Move nextMove(List<List<int>> board, Player player, Player opponent) {
    // for (int i=0;i<3;i++){
    //   for (int j=0;j<3;j++) {
    //     if(board)
    //   }
    // }
    Computer.player = player;
    Computer.opponent = opponent;
    print(board);
    Move toReturn = _findBestMove(board, player);
    print(toReturn.x);
    print(toReturn.y);
    return toReturn;
  }

  static bool _isMovesLeft(List<List<int>> board) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == 0) {
          return true;
        }
      }
    }
    return false;
  }

  static int _evaluate(List<List<int>> board) {
    for (int row = 0; row < 3; row++) {
      if (board[row][0] == board[row][1] && board[row][1] == board[row][2]) {
        if (board[row][0] == player.playerId) {
          return 10;
        } else if (board[row][0] == opponent.playerId) {
          return -10;
        }
      }
    }

    for (int col = 0; col < 3; col++) {
      if (board[0][col] == board[1][col] && board[1][col] == board[2][col]) {
        if (board[0][col] == player.playerId) {
          return 10;
        } else if (board[0][col] == opponent.playerId) {
          return -10;
        }
      }
    }

    if (board[0][0] == board[1][1] && board[1][1] == board[2][2]) {
      if (board[0][0] == player.playerId) {
        return 10;
      } else if (board[0][0] == opponent.playerId) {
        return -10;
      }

      if (board[0][2] == board[1][1] && board[1][1] == board[2][0]) {
        if (board[0][2] == player.playerId) {
          return 10;
        } else if (board[0][2] == opponent.playerId) {
          return -10;
        }
      }
    }
    return 0;
  }

  static int _minimax(List<List<int>> board, int depth, bool isMax) {
    int score = _evaluate(board);

    if (score != 0) return score + (score < 0 ? -depth : depth);

    if (_isMovesLeft(board) == false) return 0;

    if (isMax) {
      int best = -1000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == 0) {
            board[i][j] = player.playerId;

            best = max(best, _minimax(board, depth + 1, !isMax));

            board[i][j] = 0;
          }
        }
      }
      return best;
    } else {
      int best = 1000;

      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == 0) {
            board[i][j] = opponent.playerId;
            best = min(best, _minimax(board, depth + 1, !isMax));
            board[i][j] = 0;
          }
        }
      }
      return best;
    }
  }

  static Move _findBestMove(List<List<int>> board, Player player) {
    int bestVal = -1000;
    Move bestMove = Move(player: player, x: -1, y: -1);

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == 0) {
          board[i][j] = player.playerId;
          int moveVal = _minimax(board, 0, false);
          print("(${j},${i}):${moveVal}");
          board[i][j] = 0;

          if (moveVal > bestVal) {
            bestMove.y = i;
            bestMove.x = j;
            bestVal = moveVal;
          }
        }
      }
    }
    return bestMove;
  }
}
