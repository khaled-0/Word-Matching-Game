import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_matching_game/data/board_state.dart';
import 'package:word_matching_game/data/player_state.dart';
import 'package:word_matching_game/game/controls/controls_view.dart';

import 'board/board_view.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.boardSize, required this.players});

  final int boardSize;
  final List<Player> players;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PlayerState(players)),
          ChangeNotifierProvider(
            create: (c) => BoardState(context: c, size: boardSize),
          ),
        ],
        child: Stack(
          children: [
            InteractiveViewer(
              transformationController: centerTransform,
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

  TransformationController get centerTransform {
    // Epic matrix math to center the board
    // so, just get the size of screen, divide by half, subtract half of board size

    final double boardSizeHalf = BoardView.cellSize * (boardSize / 2);
    final screen = WidgetsBinding.instance.platformDispatcher.views.first;

    return TransformationController()
      ..value.translate(
        (screen.physicalSize.width / 2.75) - boardSizeHalf,
        (screen.physicalSize.height / 2) - boardSizeHalf,
      );
  }
}
