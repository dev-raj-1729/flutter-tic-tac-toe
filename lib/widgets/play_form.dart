import 'package:flutter/material.dart';

class PlayForm extends StatefulWidget {
  @override
  _PlayFormState createState() => _PlayFormState();
}

class _PlayFormState extends State<PlayForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            initialValue: "PlayerName",
          )
        ],
      ),
    );
  }
}
