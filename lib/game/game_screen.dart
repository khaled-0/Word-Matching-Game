import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_matching_game/data/board_state.dart';
import 'package:word_matching_game/data/player_state.dart';
import 'package:word_matching_game/game/controls/controls_view.dart';

import 'board/board_view.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Epic matrix math to center the board
    // final TransformationController transformationController =
    //     TransformationController();
    // transformationController.value.translate(
    //   (MediaQuery.of(context).size.width / 2) - (70 * 5),
    //   (MediaQuery.of(context).size.height / 2) - (70 * 5),
    // );
    //

    return Material(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BoardState(size: 10)),
          ChangeNotifierProvider(create: (_) => PlayerState(count: 4))
        ],
        child: Stack(
          children: [
            InteractiveViewer(
              // transformationController: transformationController,
              boundaryMargin: const EdgeInsets.all(double.infinity),
              constrained: false,
              scaleEnabled: false,
              child: const BoardView(),
            ),
            const Positioned(
              right: -4,
              top: 0,
              bottom: 0,
              child: ControlsView(),
            ),
          ],
        ),
      ),
    );
  }
}
