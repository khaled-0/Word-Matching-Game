import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:word_matching_game/data/board_state.dart';
import 'package:word_matching_game/data/player_state.dart';

class KeyboardView extends StatelessWidget {
  const KeyboardView({super.key});

  final letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  @override
  Widget build(BuildContext context) {
    final board = Provider.of<BoardState>(context, listen: false);
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceAround,
      runAlignment: WrapAlignment.spaceAround,
      children: letters.split("").map((k) {
        return keyView(k, context, board);
      }).toList(),
    );
  }

  Widget keyView(String key, BuildContext context, BoardState board) {
    final player = Provider.of<PlayerState>(context).currentPlayer;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => board.handleKeyPress(
        KeyDownEvent(
          character: key,
          logicalKey: const LogicalKeyboardKey(-1),
          physicalKey: const PhysicalKeyboardKey(-1),
          timeStamp: Duration.zero,
        ),
      ),
      child: AnimatedContainer(
        height: 55,
        width: 65,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: player.color.withOpacity(.1),
        ),
        duration: Durations.long4,
        child: Center(child: Text(key)),
      ),
    );
  }
}
