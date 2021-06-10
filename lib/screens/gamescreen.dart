import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/models/board.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/gamescreen';
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var board = Board();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.red,
          height: 400,
          width: 400,
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) => ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                // onSurface: Colors.red,
                onPrimary: theme.primaryColor,
                primary: Colors.white,
              ),
              child: Text(
                board.matrix[index ~/ 3][index % 3].toString(),
              ),
            ),
            itemCount: 9,
          ),
        ),
      ),
      backgroundColor: theme.primaryColor,
    );
  }
}
