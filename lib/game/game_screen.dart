import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_matching_game/data/board_state.dart';

import 'components/board.dart';

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
      child: ChangeNotifierProvider(
        create: (context) => BoardState(size: 10),
        child: Stack(
          children: [
            InteractiveViewer(
              // transformationController: transformationController,
              boundaryMargin: const EdgeInsets.all(double.infinity),
              constrained: false,
              scaleEnabled: false,
              child: Board(),
            ),
            Positioned(
              right: 8,
              top: 8,
              bottom: 8,
              child: Card(
                child: Text("fffffffffffffff"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
