import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:word_matching_game/data/words.dart';
import 'package:word_matching_game/game/game_screen.dart';

main() async {
  await Words.init();

  runApp(
    MaterialApp(
      title: 'Word Matching Game',
      debugShowCheckedModeBanner: false,
      scrollBehavior: scrollBehavior,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff069af1),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff069af1),
          brightness: Brightness.dark,
        ),
      ),
      home: const GameScreen(),
    ),
  );
}

ScrollBehavior get scrollBehavior => const MaterialScrollBehavior().copyWith(
      physics: const BouncingScrollPhysics(),
      dragDevices: PointerDeviceKind.values.toSet(),
    );
