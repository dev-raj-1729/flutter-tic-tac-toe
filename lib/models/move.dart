import 'package:flutter_tic_tac_toe/models/player.dart';

class Move {
  int x;
  int y;
  Player player;
  Move({
    required this.x,
    required this.y,
    required this.player,
  });
}
