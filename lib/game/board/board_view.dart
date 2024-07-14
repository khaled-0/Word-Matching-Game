import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:word_matching_game/data/board_state.dart';

import 'board_cell_view.dart';

class BoardView extends StatefulWidget {
  static const double cellSize = 65;

  const BoardView({super.key});

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  late BoardState board;

  @override
  void initState() {
    super.initState();
    board = Provider.of<BoardState>(context, listen: false);
    HardwareKeyboard.instance.addHandler(board.handleKeyPress);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: BoardView.cellSize * board.size,
      child: Consumer<BoardState>(
        builder: (context, board, child) {
          return GridView.builder(
            itemCount: board.items.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: board.size,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemBuilder: (_, index) => BoardCellView(
              board.items[index],
              selected: board.isCellSelected(index),
              onTap: () {
                // focusNode.requestFocus();
                board.select(index);
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    HardwareKeyboard.instance.removeHandler(board.handleKeyPress);
  }
}
