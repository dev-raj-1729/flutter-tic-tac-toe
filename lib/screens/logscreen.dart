import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/log.dart';
import '../widgets/log_tile.dart';

class LogScreen extends StatelessWidget {
  static const routeName = '/logscreen';
  @override
  Widget build(BuildContext context) {
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
                  return LogTile(
                    log: log,
                    removeItem: logProvider.removeItemById,
                  );
                },
              ),
            );
          }),
    );
  }
}
