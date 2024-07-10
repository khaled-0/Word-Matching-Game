import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'models.dart';

class BoardState extends ChangeNotifier {
  final List<BoardCell> _data;

  /// This is the matrix size. e.g 10x10
  final int size;

  BoardState({
    required this.size,
  }) : _data = List.generate(size * size, BoardCell.new);

  void color(int i) {
    _data[i].value = "K";
    notifyListeners();
  }

  UnmodifiableListView<BoardCell> get items => UnmodifiableListView(_data);
}
