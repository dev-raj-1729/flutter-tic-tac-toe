import 'package:flutter/material.dart';

class Player {
  int playerId;
  String playerName;
  IconData symbol;
  MaterialColor color;
  Player({
    required this.playerId,
    required this.playerName,
    required this.symbol,
    required this.color,
  });
}
