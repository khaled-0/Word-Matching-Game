import 'dart:collection';

import 'package:flutter/material.dart';

class Player {
  final int index;
  final Color color;
  String? customName;
  int score = 0;
  List<String> words = [];

  String get name => customName ?? "P${index + 1}";

  Player(this.index) : color = Colors.primaries[index];
}

class PlayerState extends ChangeNotifier {
  final List<Player> _players;
  int _currentPlayerIndex = 0;

  PlayerState.create({
    required int count,
  }) : _players = List.generate(count, Player.new);

  PlayerState(List<Player> players) : _players = players;

  Player get currentPlayer {
    return _players[_currentPlayerIndex];
  }

  void updatePlayerScore(String? word) {
    if (word == null) return;
    currentPlayer.score += word.length;
    currentPlayer.words.add(word);
    notifyListeners();
  }

  void nextPlayer() {
    _currentPlayerIndex = ++_currentPlayerIndex % _players.length;
    notifyListeners();
  }

  int get totalPlayers => _players.length;

  UnmodifiableListView<Player> get items => UnmodifiableListView(_players);
}
