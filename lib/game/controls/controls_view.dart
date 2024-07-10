import 'package:flutter/material.dart';
import 'package:word_matching_game/game/controls/controls_toolbar.dart';
import 'package:word_matching_game/game/controls/keyboard_view.dart';
import 'package:word_matching_game/game/controls/score_view.dart';

class ControlsView extends StatelessWidget {
  const ControlsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: const Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              KeyboardView(),
              Spacer(),
              SizedBox(height: 6),
              ScoreView(),
              SizedBox(height: 6),
              ControlsToolbar(),
            ],
          ),
        ),
      ),
    );
  }
}
