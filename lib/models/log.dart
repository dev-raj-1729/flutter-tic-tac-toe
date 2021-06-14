import 'package:flutter_tic_tac_toe/models/logitem.dart';
import 'package:localstore/localstore.dart';
import 'package:flutter/material.dart';

class Log with ChangeNotifier {
  static const path = 'logs';
  final Localstore db;
  late List<LogItem> _logs;
  Log(this.db);
  Map<String, String> _logItemToMap(LogItem logItem) {
    return {
      'winner': logItem.winner,
      'loser': logItem.loser,
      'date': logItem.date.toIso8601String(),
    };
  }

  LogItem _mapToLogItem(Map<String, dynamic> map, String id) {
    return LogItem(
        winner: map['winner']!,
        loser: map['loser']!,
        date: DateTime.parse(map['date']!));
  }

  Future<void> fetchAndUpdate() async {
    final items = await db.collection(path).get();
    _logs = [];
    items!.forEach((key, value) {
      print(key.split('/').last);
      _logs.add(_mapToLogItem(value, key.split('/').last));
    });
    print(_logs);
  }

  void addItem(LogItem logItem) {
    final id = db.collection(path).doc().id;
    logItem.id = id;
    final data = _logItemToMap(logItem);
    db.collection(path).doc(id).set(data);
  }

  void removeItemById(String id) {
    _logs.removeWhere((element) => element.id == id);
    db.collection(path).doc(id).delete();
  }

  List<LogItem> get logs {
    return [..._logs];
  }
}
