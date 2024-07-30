import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_matching_game/data/player_state.dart';
import 'package:word_matching_game/main.dart';
import 'package:word_matching_game/menus/player_info_dialog.dart';

class ScoreView extends StatelessWidget {
  const ScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerState>(
      builder: (context, players, child) {
        return Wrap(
          spacing: 6,
          runSpacing: 6,
          children: players.items
              .map((p) => _scoreView(context, p, players.currentPlayer == p))
              .toList(),
        );
      },
    );
  }

  Widget _scoreView(BuildContext context, Player player, bool current) {
    final cfs = current ? CrossFadeState.showFirst : CrossFadeState.showSecond;
    return AnimatedCrossFade(
      firstChild: Card.outlined(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: _playerChip(context, player, current),
      ),
      secondChild: Card.filled(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: _playerChip(context, player, current),
      ),
      crossFadeState: cfs,
      duration: Durations.long4,
    );
  }

  Widget _playerChip(BuildContext context, Player player, bool current) {
    return ListTile(
      onTap: () => PlayerInfoDialog(player).showAsDialog(context),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      leading: CircleAvatar(backgroundColor: player.color),
      title: Text(player.name),
      trailing: Chip(label: Text(player.score.toString())),
      dense: true,
    );
  }
}
