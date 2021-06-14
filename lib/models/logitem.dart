class LogItem {
  String id;
  String winner;
  String loser;
  DateTime date;
  LogItem(
      {required this.winner,
      required this.loser,
      required this.date,
      this.id = ""});
}
