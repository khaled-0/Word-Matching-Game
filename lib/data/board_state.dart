import 'dart:collection';

import 'package:flutter/material.dart';

class BoardCell {
  final int index;
  String? value;
  Color? color;

  BoardCell(this.index);

  bool get isEmpty => value == null || value!.trim().isEmpty;
}

class BoardState extends ChangeNotifier {
  final List<BoardCell> _data;


  /// This is the matrix size. e.g 10x10
  final int size;

  int? _selectedCell;

  BoardState({
    required this.size,
  }) : _data = List.generate(size * size, BoardCell.new);

  bool handleKeyPress(KeyEvent event) {
    if (event.character == null) return false;
    if (_selectedCell == null) return false;
    if (_data[_selectedCell!].value != null) return false;
    _data[_selectedCell!].value = event.character!.toUpperCase();
    _selectedCell = null;
    notifyListeners();
    return true;
  }

  void select(int? i) {
    if (_selectedCell == i) return;
    _selectedCell = i;
    notifyListeners();
  }

  UnmodifiableListView<BoardCell> get items => UnmodifiableListView(_data);

  bool isCellSelected(int index) => _selectedCell == index;
}
