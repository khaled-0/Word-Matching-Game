import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_matching_game/data/player_state.dart';

class ScoreView extends StatelessWidget {
  const ScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerState>(
      builder: (context, players, child) {
        return Wrap(
          spacing: 6,
          runSpacing: 6,
          children: players.items.map(scoreChip).toList(),
        );
      },
    );
  }

  Widget scoreChip(Player player) {
    return Card.outlined(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          onTap: () {},
          leading: CircleAvatar(backgroundColor: player.color),
          title: Text(player.name),
          trailing: Chip(label: Text(player.score.toString())),
          dense: true,
        ),
      ),
    );
  }
}
