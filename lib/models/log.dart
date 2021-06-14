import 'package:flutter/material.dart';

import 'package:localstore/localstore.dart';

import 'log_item.dart';

class Log with ChangeNotifier {
  static const path = 'logs';
  final Localstore db;
  late List<LogItem> _logs;
  Log(this.db);
  Map<String, dynamic> _logItemToMap(LogItem logItem) {
    return {
      'winner': logItem.winner,
      'loser': logItem.loser,
      'date': logItem.date.toIso8601String(),
      'tie': logItem.tie,
    };
  }

  LogItem _mapToLogItem(Map<String, dynamic> map, String id) {
    return LogItem(
      id: id,
      winner: map['winner']!,
      loser: map['loser']!,
      date: DateTime.parse(
        map['date']!,
      ),
      tie: map['tie'],
    );
  }

  Future<void> fetchAndUpdate() async {
    final items = await db.collection(path).get();
    if (items == null) return;
    _logs = [];
    items.forEach((key, value) {
      _logs.add(_mapToLogItem(value, key.split('/').last));
    });
    notifyListeners();
  }

  void addItem(LogItem logItem) {
    final id = db.collection(path).doc().id;
    logItem.id = id;
    final data = _logItemToMap(logItem);
    db.collection(path).doc(id).set(data);
    notifyListeners();
  }

  void removeItemById(String id) {
    _logs.removeWhere((element) {
      return element.id == id;
    });
    db.collection(path).doc(id).delete();
    notifyListeners();
  }

  List<LogItem> get logs {
    _logs.sort((item1, item2) {
      if (item1.date.isAfter(item2.date)) {
        return -1;
      }
      return 1;
    });
    return [..._logs];
  }
}
