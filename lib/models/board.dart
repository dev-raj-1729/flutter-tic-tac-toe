import 'package:flutter/cupertino.dart';

class Board with ChangeNotifier {
  late List<List<int>> _matrix;
  Board() {
    _matrix = new List<List<int>>.generate(3, (_) => List.filled(3, 0));
    notifyListeners();
    print(_matrix);
  }
  List<List<int>> get matrix {
    return [..._matrix];
  }
}
