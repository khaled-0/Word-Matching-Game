import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:word_matching_game/data/board_state.dart';

class Words {
  static late final Set<String> _wordSet;

  /// Call this before runApp to load the words
  /// from words.txt into a set
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final words = await rootBundle.loadString("assets/words.txt");
    _wordSet = words.split(",").toSet();
  }

  /// Call this method intensively to know if some input <word> is a valid word
  static bool has(String word) => _wordSet.contains(word);

  static String? fromSelectedCell(BoardState board, int selectedCell) {
    if (board.get(selectedCell).isEmpty) return null;

    var words = <String>{
      ..._WordUtils.getVerticalWords(board.items, selectedCell, board.size),
      ..._WordUtils.getHorizontalWords(board.items, selectedCell, board.size)
    };

    // Ignore already used words
    words.removeWhere(board.isExistingWord);
    // Sort by length descending in case of multiple
    if (words.length > 1) words.reduce((a, b) => a.length > b.length ? a : b);

    return words.firstOrNull;
  }
}

class _WordUtils {
  static Set<String> getVerticalWords(
    List<BoardCell> board,
    int index,
    int columnLength,
  ) {
    if (board[index].isEmpty) return {};
    final inputWord = board[index].value!;

    // Bottom letters till blank field
    var bottomWord = '';
    for (var i = index + columnLength; i < board.length; i += columnLength) {
      if (board[i].isEmpty) break;
      bottomWord += board[i].value!;
    }

    // Top letters till blank field
    var topWord = '';
    for (var i = index - columnLength; i >= 0; i -= columnLength) {
      if (board[i].isEmpty) break;
      topWord += board[i].value!;
    }

    if (topWord.isEmpty && bottomWord.isEmpty) return {};

    var verticalTop = findValidWordsFromRight(reverse(topWord) + inputWord);
    var verticalBottom = findValidWordsFromLeft(inputWord + bottomWord);

    return {...?verticalTop, ...?verticalBottom};
  }

  static Set<String> getHorizontalWords(
    List<BoardCell> board,
    int index,
    int rowLength,
  ) {
    if (board[index].isEmpty) return {};
    final inputWord = board[index].value!;

    // Right letters till blank field
    var rightWord = '';
    for (var i = index + 1; i < board.length; i++) {
      if (i % rowLength == 0) break; // Stop at the end of the row
      if (board[i].isEmpty) break;
      rightWord += board[i].value!;
    }

    // Left letters till blank field
    var leftWord = '';
    for (var i = index - 1; i >= 0; i--) {
      if (i % rowLength == rowLength - 1) break; // Stop at the start of the row
      if (board[i].isEmpty) break;
      leftWord += board[i].value!;
    }

    if (leftWord.isEmpty && rightWord.isEmpty) return {};

    var horizontalLeft = findValidWordsFromLeft(reverse(leftWord) + inputWord);
    var horizontalRight = findValidWordsFromRight(inputWord + rightWord);

    return {...?horizontalLeft, ...?horizontalRight};
  }

  static Set<String>? findValidWordsFromLeft(String string) {
    string = string.toLowerCase();

    Set<String> words = {};
    for (var j = 1; j < string.length; j++) {
      final currentWord = string.substring(0, j);

      if (currentWord.length <= 2) continue;
      if (!Words.has(currentWord)) continue;

      words.add(currentWord);
    }

    if (words.isNotEmpty) return words;
    return null;
  }

  static Set<String>? findValidWordsFromRight(String string) {
    string = string.toLowerCase();
    final i = string.length;

    Set<String> words = {};
    for (var j = i - 1; j > string.length; j--) {
      final currentWord = string.substring(j, i);

      if (currentWord.length <= 2) continue;
      if (!Words.has(currentWord)) continue;

      words.add(currentWord);
    }

    if (words.isNotEmpty) return words;
    return null;
  }

  /// Finds all the unique valid and at least 3 character long
  /// English word from some string.
  /// UNUSED
  static Set<String>? findValidWords(String string) {
    string = string.toLowerCase();

    Set<String> words = {};
    for (var i = 0; i < string.length; i++) {
      for (var j = i + 1; j <= string.length; j++) {
        final currentWord = string.substring(i, j);

        if (currentWord.length <= 2) continue;
        if (!Words.has(currentWord)) continue;

        words.add(currentWord);
      }
    }

    if (words.isNotEmpty) return words;
    return null;
  }

  /// Only works for ASCII strings
  static String reverse(String str) => str.split('').reversed.join().toString();
}
