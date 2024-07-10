import 'dart:collection';

import 'package:flutter/material.dart';

class Player {
  final int index;
  String name;
  Color color;
  int score = 0;
  List<String> words = [];

  Player(this.index)
      : name = "P$index",
        color = Colors.primaries[index];
}

class PlayerState extends ChangeNotifier {
  final List<Player> _players;
  int _currentPlayerIndex = 0;

  PlayerState({
    required int count,
  }) : _players = List.generate(count, Player.new);

  Player get currentPlayer {
    return _players[_currentPlayerIndex];
  }

  void nextPlayer() {
    _currentPlayerIndex = _currentPlayerIndex % _players.length;
    notifyListeners();
  }

  int get totalPlayers => _players.length;

  UnmodifiableListView<Player> get items => UnmodifiableListView(_players);
}
