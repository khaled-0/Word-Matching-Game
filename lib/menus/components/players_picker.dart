import 'package:flutter/material.dart';
import 'package:word_matching_game/data/player_state.dart';

class PlayersPicker extends StatelessWidget {
  static List<int> choices = [2, 3, 4, 5, 6, 7, 8];

  const PlayersPicker({
    super.key,
    required this.players,
    required this.onSelected,
    required this.count,
  });

  final int count;
  final List<Player> players;
  final void Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Text('Players', style: Theme.of(context).textTheme.titleMedium),
          const Spacer(),
          Expanded(
            flex: 8,
            child: Wrap(
              spacing: 4,
              runSpacing: 4,
              alignment: WrapAlignment.center,
              children: choices.map((e) {
                return ChoiceChip(
                  label: Text(e.toString()),
                  selected: count == e,
                  onSelected: (_) => onSelected(e),
                );
              }).toList(),
            ),
          ),
        ]),
        const SizedBox(height: 16),
        Text(
          'Names',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          alignment: WrapAlignment.center,
          children: [...players.sublist(0, count).map(playerNameEditor)],
        ),
      ],
    );
  }

  //TODO Better layout
  //Warp center items
  Widget playerNameEditor(Player player) {
    return SizedBox(
      width: 172,
      child: TextFormField(
        initialValue: player.customName,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(backgroundColor: player.color),
          ),
          hintText: "Player ${player.index + 1}",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: (value) => player.customName = value,
      ),
    );
  }
}
