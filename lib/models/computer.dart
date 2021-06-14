class Utils {
  static bool isBoardFull(List<int> board) {
    for (var val in board) {
      if (val == Ai.emptySpace) return false;
    }

    return true;
  }

  static bool isMoveLegal(List<int> board, int move) {
    if (move < 0 || move >= board.length || board[move] != Ai.emptySpace)
      return false;

    return true;
  }

  static int evaluateBoard(List<int> board) {
    for (var list in Ai.winConditionsList) {
      if (board[list[0]] != Ai.emptySpace &&
          board[list[0]] == board[list[1]] &&
          board[list[0]] == board[list[2]]) {
        return board[list[0]];
      }
    }

    if (isBoardFull(board)) {
      return Ai.draw;
    }

    return Ai.noWinnersYet;
  }

  static int flipPlayer(int currentPlayer) {
    return -1 * currentPlayer;
  }
}

class Ai {
  static const int human = 1;
  static const int aiPlayer = -1;
  static const int noWinnersYet = 0;
  static const int draw = 2;

  static const int emptySpace = 0;

  static const int winScore = 100;
  static const int drawScore = 0;
  static const int loseScore = -100;

  static const winConditionsList = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  int play(List<int> board, int currentPlayer) {
    return _getBestMove(board, currentPlayer).move;
  }

  int _getBestScore(List<int> board, int currentPlayer) {
    int evaluation = Utils.evaluateBoard(board);

    if (evaluation == currentPlayer) return winScore;

    if (evaluation == draw) return drawScore;

    if (evaluation == Utils.flipPlayer(currentPlayer)) {
      return loseScore;
    }

    return _getBestMove(board, currentPlayer).score;
  }

  ComputerMove _getBestMove(List<int> board, int currentPlayer) {
    List<int> newBoard;

    ComputerMove bestMove = ComputerMove(score: -10000, move: -1);

    for (int currentMove = 0; currentMove < board.length; currentMove++) {
      if (!Utils.isMoveLegal(board, currentMove)) continue;

      newBoard = List.from(board);

      newBoard[currentMove] = currentPlayer;

      int nextScore = -_getBestScore(newBoard, Utils.flipPlayer(currentPlayer));

      if (nextScore > bestMove.score) {
        bestMove.score = nextScore;
        bestMove.move = currentMove;
      }
    }

    return bestMove;
  }
}

class ComputerMove {
  int score;
  int move;

  ComputerMove({required this.score, required this.move});
}
