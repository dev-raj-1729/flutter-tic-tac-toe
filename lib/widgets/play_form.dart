import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/models/player.dart';

class PlayForm extends StatefulWidget {
  Player player;
  PlayForm(this.player);
  @override
  _PlayFormState createState() => _PlayFormState();
}

class _PlayFormState extends State<PlayForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Container(
          height: 50 + MediaQuery.of(context).viewInsets.bottom,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.player.playerName,
                onFieldSubmitted: (value) {
                  widget.player.playerName = value;
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
