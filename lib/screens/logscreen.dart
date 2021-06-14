import 'package:flutter/material.dart';

class LogScreen extends StatelessWidget {
  static const routeName = '/logscreen';
  const LogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('LogScreen'),
      ),
    );
  }
}
