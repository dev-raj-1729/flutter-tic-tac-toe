import 'package:flutter/material.dart';

import '../models/player.dart';

class PlayForm extends StatefulWidget {
  final Player player;
  PlayForm(this.player);
  @override
  _PlayFormState createState() => _PlayFormState();
}

class _PlayFormState extends State<PlayForm> {
  final _formKey = GlobalKey<FormState>();
  void _submitForm() {
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    _formKey.currentState!.save();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Container(
          height: 120 + MediaQuery.of(context).viewInsets.bottom,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.player.playerName,
                autovalidateMode: AutovalidateMode.always,
                onSaved: (value) {
                  widget.player.playerName = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Player name can't be empty";
                  }
                  if (value.length > 10) {
                    return "Player name must be 10 characters or less";
                  }
                  return null;
                },
              ),
              TextButton(onPressed: _submitForm, child: Text('OK'))
            ],
          ),
        ),
      ),
    );
  }
}
