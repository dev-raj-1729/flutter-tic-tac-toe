import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'alerts.dart';
import '../models/log_item.dart';

class LogTile extends StatelessWidget {
  final LogItem log;
  final void Function(String) removeItem;

  LogTile({
    required this.log,
    required this.removeItem,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) {
        removeItem(log.id);
      },
      confirmDismiss: (_) => Alerts.dismissLogAlert(context),
      key: Key(log.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.red),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerLeft,
      ),
      child: Card(
        child: ListTile(
          title: Text(
              '${log.winner} ${log.tie ? 'tied' : 'won'} against ${log.loser}'),
          subtitle: Text('Date : ${DateFormat('dd-MM-yyyy').format(log.date)}'),
        ),
      ),
    );
  }
}
