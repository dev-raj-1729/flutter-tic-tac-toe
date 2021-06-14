class LogItem {
  String id;
  String winner;
  String loser;
  DateTime date;
  bool tie;
  LogItem({
    required this.winner,
    required this.loser,
    required this.date,
    this.id = "",
    required this.tie,
  });
}
