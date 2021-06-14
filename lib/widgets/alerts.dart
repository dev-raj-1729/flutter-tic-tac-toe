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
}
