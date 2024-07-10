import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:word_matching_game/data/board_state.dart';

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
      children: letters.split("").map((k) => keyView(k, board)).toList(),
    );
  }

  Widget keyView(String key, BoardState board) {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () => board.handleKeyPress(
        KeyDownEvent(
          character: key,
          logicalKey: const LogicalKeyboardKey(-1),
          physicalKey: const PhysicalKeyboardKey(-1),
          timeStamp: Duration.zero,
        ),
      ),
      child: SizedBox(
        height: 55,
        width: 20,
        child: Center(child: Text(key)),
      ),
    );
  }
}
