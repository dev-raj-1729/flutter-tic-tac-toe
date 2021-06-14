class Utils {
  static bool isBoardFull(List<int> board) {
    for (var val in board) {
      if (val == Ai.EMPTY_SPACE) return false;
    }

    return true;
  }

  static bool isMoveLegal(List<int> board, int move) {
    if (move < 0 || move >= board.length || board[move] != Ai.EMPTY_SPACE)
      return false;

    return true;
  }

  static int evaluateBoard(List<int> board) {
    for (var list in Ai.WIN_CONDITIONS_LIST) {
      if (board[list[0]] != Ai.EMPTY_SPACE &&
          board[list[0]] == board[list[1]] &&
          board[list[0]] == board[list[2]]) {
        return board[list[0]];
      }
    }

    if (isBoardFull(board)) {
      return Ai.DRAW;
    }

    return Ai.NO_WINNERS_YET;
  }

  static int flipPlayer(int currentPlayer) {
    return -1 * currentPlayer;
  }
}

class Ai {
  static const int HUMAN = 1;
  static const int AI_PLAYER = -1;
  static const int NO_WINNERS_YET = 0;
  static const int DRAW = 2;

  static const int EMPTY_SPACE = 0;
  static const SYMBOLS = {EMPTY_SPACE: "", HUMAN: "X", AI_PLAYER: "O"};

  static const int WIN_SCORE = 100;
  static const int DRAW_SCORE = 0;
  static const int LOSE_SCORE = -100;

  static const WIN_CONDITIONS_LIST = [
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

    if (evaluation == currentPlayer) return WIN_SCORE;

    if (evaluation == DRAW) return DRAW_SCORE;

    if (evaluation == Utils.flipPlayer(currentPlayer)) {
      return LOSE_SCORE;
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
