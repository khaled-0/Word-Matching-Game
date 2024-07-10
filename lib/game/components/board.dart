import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_matching_game/data/board_state.dart';
import 'package:word_matching_game/data/models.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  final double cellSize = 70;

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardState>(
      builder: (context, board, child) {
        return SizedBox.square(
          dimension: cellSize * board.size,
          child: GridView.builder(
            itemCount: board.items.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: board.size,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){},
                child: itemBuilder(board.items[index]),
              );
            },
          ),
        );
      },
    );
  }

  Widget itemBuilder(BoardCell cell) {
    return Text(cell.value ?? cell.index.toString());
  }
}
