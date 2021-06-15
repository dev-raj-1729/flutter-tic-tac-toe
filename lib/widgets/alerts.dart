import 'package:flutter/material.dart';

class Alerts {
  static Future<bool?> dismissLogAlert(BuildContext context) {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete log?'),
          content: Text('Are you sure you want to delete this?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('No'),
            )
          ],
        );
      },
    );
  }

  static void showWinnerAlert(BuildContext context, String msg) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over!'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  static Future<bool?> startNewGameAlert(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Start New Game?'),
        content: Text('All progress in current one will be lost'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  static Future<bool?> goBackAlert(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit to main menu?'),
        content: Text('All progress in current game will be lost'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('No'),
          ),
        ],
      ),
    );
  }
}
