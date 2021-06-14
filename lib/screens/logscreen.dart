import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/models/log.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class LogScreen extends StatelessWidget {
  static const routeName = '/logscreen';
  const LogScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final logProvider = Provider.of<Log>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: FutureBuilder<void>(
          future: Provider.of<Log>(context, listen: false).fetchAndUpdate(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<Log>(
              builder: (context, logProvider, _) => ListView.builder(
                itemCount: logProvider.logs.length,
                itemBuilder: (context, index) {
                  final log = logProvider.logs[index];
                  return Dismissible(
                    onDismissed: (_) {
                      logProvider.removeItemById(log.id);
                    },
                    key: Key(log.id),
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    child: Card(
                      child: ListTile(
                        title: Text('${log.winner} won against ${log.loser}'),
                        subtitle: Text(
                            'Date : ${DateFormat('dd-MM-yyyy').format(log.date)}'),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
