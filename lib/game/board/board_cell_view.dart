import 'package:flutter/material.dart';
import 'package:word_matching_game/data/board_state.dart';

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
      onPointerDown: cell.isEmpty ? (p) => onTap() : null,
      child: MouseRegion(
        cursor:
            cell.isEmpty ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: selected ? Border.all(color: Colors.red) : null,
          ),
          child: Center(
            child: Text(
              cell.value ?? cell.index.toString(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: cell.color ?? Theme.of(context).hintColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
