import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_matching_game/data/player_state.dart';
import 'package:word_matching_game/data/words.dart';

class BoardCell {
  final int index;
  String? value;
  Color? color;

  BoardCell(this.index);

  bool get isEmpty => value == null || value!.trim().isEmpty;
}

class BoardState extends ChangeNotifier {
  final List<BoardCell> _data;
  final PlayerState _playerState;

  final Set<String> _matchedWords = {};

  bool isExistingWord(String word) => _matchedWords.contains(word);

  /// This is the matrix size. e.g 10x10
  final int size;

  int? _selectedCell;

  BoardState({
    required BuildContext context,
    required this.size,
  })  : _data = List.generate(size * size, BoardCell.new),
        _playerState = Provider.of<PlayerState>(context, listen: false);

  bool handleKeyPress(KeyEvent event) {
    if (event.character == null) return false;
    if (_selectedCell == null) return false;
    if (_data[_selectedCell!].value != null) return false;

    _data[_selectedCell!].value = event.character!.toUpperCase();
    _data[_selectedCell!].color = _playerState.currentPlayer.color;

    final word = Words.fromSelectedCell(this, _selectedCell!);
    if (word != null) _matchedWords.add(word);
    _playerState.updatePlayerScore(word);

    _playerState.nextPlayer();
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

  BoardCell get(int index) => _data[index];

  bool isCellSelected(int index) => _selectedCell == index;
}
