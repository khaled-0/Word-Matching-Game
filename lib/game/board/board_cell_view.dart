import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_matching_game/data/board_state.dart';
import 'package:word_matching_game/data/player_state.dart';

class BoardCellView extends StatelessWidget {
  final BoardCell cell;

  final void Function() onTap;
  final bool selected;

  const BoardCellView(
    this.cell, {
    super.key,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: onTapListener,
      child: MouseRegion(
        cursor: cursorStyle,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: borderStyle(context),
          ),
          child: Center(
            child: Text(
              cell.value ?? cell.index.toString(),
              style: textStyle(context),
            ),
          ),
        ),
      ),
    );
  }

  Border? borderStyle(BuildContext context) {
    final players = Provider.of<PlayerState>(context, listen: false);
    if (selected) return Border.all(color: players.currentPlayer.color);
    return null;
  }

  TextStyle? textStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge?.copyWith(
          color: cell.color ?? Theme.of(context).hintColor,
        );
  }

  MouseCursor get cursorStyle {
    if (cell.isEmpty) return SystemMouseCursors.click;
    return SystemMouseCursors.basic;
  }

  void Function(PointerDownEvent)? get onTapListener {
    if (cell.isEmpty) return (p) => onTap();
    return null;
  }
}
