import 'dart:math';

import 'package:flutter/material.dart';

class Player {
  final int index;
  String name;
  Color color;
  int score = 0;
  List<String> words = [];

  Player(this.index)
      : name = "P$index",
        color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
}

class PlayerState extends ChangeNotifier {
  final List<Player> _players;

  /// This is the matrix size. e.g 10x10
  final int count;

  int? _selectedCell;

  PlayerState({
    required this.count,
  }) : _players = List.generate(count, Player.new);
}
