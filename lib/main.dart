import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:word_matching_game/game/game_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Word Matching Game',
      debugShowCheckedModeBanner: false,
      scrollBehavior: scrollBehavior,
      home: const GameScreen(),
    ),
  );
}

ScrollBehavior get scrollBehavior => const MaterialScrollBehavior().copyWith(
      physics: const BouncingScrollPhysics(),
      dragDevices: PointerDeviceKind.values.toSet(),
    );
