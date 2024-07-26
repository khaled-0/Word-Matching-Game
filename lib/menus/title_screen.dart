import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_matching_game/data/player_state.dart';
import 'package:word_matching_game/game/game_screen.dart';
import 'package:word_matching_game/main.dart';
import 'package:word_matching_game/menus/components/board_size_picker.dart';
import 'package:word_matching_game/menus/components/players_picker.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  int boardSize = 12;
  int playersCount = 4;
  List<Player> players = List.generate(PlayersPicker.choices.last, Player.new);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
            minHeight: double.maxFinite,
          ),
          child: Card(
            margin: const EdgeInsets.all(8),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  "Epic Word Matching Game",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Card.outlined(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    child: BoardSizePicker(
                      selection: boardSize,
                      onSelected: (size) => setState(() {
                        boardSize = size;
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card.outlined(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    child: PlayersPicker(
                      players: players,
                      count: playersCount,
                      onSelected: (size) => setState(() {
                        playersCount = size;
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: FilledButton.icon(
                    onPressed: startGame,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                    label: const Text("Start The Game!!"),
                    icon: const Icon(CupertinoIcons.play),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startGame() {
    GameScreen(
      boardSize: boardSize,
      players: players.sublist(0, playersCount),
    ).pushToScreen(context);
  }
}
