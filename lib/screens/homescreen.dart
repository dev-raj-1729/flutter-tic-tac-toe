import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/models/board.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bb = Board();
    bb.matrix[1][0] = 1;
    print(bb.matrix);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose a game',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 25,
                ),
              ),
              onPressed: () {
                // print(Theme.of(context).accentColor);
              },
              child: Text('Single Player'),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: min(mediaQuery.size.width * 0.90, 350),
              height: 50,
              // padding: EdgeInsets.all(10),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('Two Players'),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
