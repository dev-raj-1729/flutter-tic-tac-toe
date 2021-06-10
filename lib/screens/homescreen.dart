import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 25,
                  )),
              onPressed: () {
                // print(Theme.of(context).accentColor);
              },
              child: Text('Single Player'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 25,
                ),
              ),
              child: Text('Two Players'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
