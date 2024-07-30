import 'package:flutter/material.dart';
import 'package:word_matching_game/data/player_state.dart';

class PlayerInfoDialog extends StatelessWidget {
  final Player player;

  const PlayerInfoDialog(this.player,{super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${player.name}'s Details"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Dismiss"),
        )
      ],
    );
  }
}
