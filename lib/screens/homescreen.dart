import 'dart:math';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../models/board.dart';
import 'gamescreen.dart';
import 'logscreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: min(250, mediaQuery.size.height * 0.25),
              alignment: Alignment.center,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Welcome',
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 70,
                    ),
                    speed: Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
              ),
            ),
            Container(
              width: min(mediaQuery.size.width * 0.90, 350),
              height: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  (Provider.of<Board>(context, listen: false)
                        ..setComputer(true))
                      .reset();
                  Navigator.of(context).pushNamed(GameScreen.routeName);
                },
                child: Text('Single Player'),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: min(mediaQuery.size.width * 0.90, 350),
              height: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('Two Players'),
                onPressed: () {
                  (Provider.of<Board>(context, listen: false)
                        ..setComputer(false))
                      .reset();
                  Navigator.of(context).pushNamed(GameScreen.routeName);
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: min(mediaQuery.size.width * 0.90, 350),
              height: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('History'),
                onPressed: () {
                  Navigator.of(context).pushNamed(LogScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
