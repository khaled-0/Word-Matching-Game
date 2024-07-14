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
      ...WordUtils.verticalWords(board.items, selectedCell, board.size),
      ...WordUtils.horizontalWords(board.items, selectedCell, board.size)
    };

    // Ignore already used words
    words.removeWhere(board.isExistingWord);
    // Sort by length descending in case of multiple
    if (words.length > 1) words.reduce((a, b) => a.length > b.length ? a : b);

    return words.firstOrNull;
  }
}

@visibleForTesting
class WordUtils {
  static Set<String> verticalWords(
    List<BoardCell> board,
    int index,
    int columnLength,
  ) {
    if (board[index].isEmpty) return {};
    final input = IndexedLetter(index, board[index].value!);

    // Bottom letters till blank field
    List<IndexedLetter> bottomWord = [];
    for (var i = index + columnLength; i < board.length; i += columnLength) {
      if (board[i].isEmpty) break;
      bottomWord.add(IndexedLetter(i, board[i].value!));
    }

    // Top letters till blank field
    List<IndexedLetter> topWord = [];
    for (var i = index - columnLength; i >= 0; i -= columnLength) {
      if (board[i].isEmpty) break;
      topWord.add(IndexedLetter(i, board[i].value!));
    }

    if (topWord.isEmpty && bottomWord.isEmpty) return {};

    final string = [...topWord.reversed, input, ...bottomWord];
    if (string.length <= 2) return {};

    final validWords = WordUtils.findValidWordsIncluding(string, input);
    if (validWords == null) return {};

    return validWords.map(WordUtils.indexedLettersToStr).toSet();
  }

  static Set<String> horizontalWords(
    List<BoardCell> board,
    int index,
    int rowLength,
  ) {
    if (board[index].isEmpty) return {};
    final input = IndexedLetter(index, board[index].value!);

    // Right letters till blank field
    List<IndexedLetter> rightWord = [];
    for (var i = index + 1; i < board.length; i++) {
      if (i % rowLength == 0) break; // Stop at the end of the row
      if (board[i].isEmpty) break;
      rightWord.add(IndexedLetter(i, board[i].value!));
    }

    // Left letters till blank field
    List<IndexedLetter> leftWord = [];
    for (var i = index - 1; i >= 0; i--) {
      if (i % rowLength == rowLength - 1) break; // Stop at the start of the row
      if (board[i].isEmpty) break;
      leftWord.add(IndexedLetter(i, board[i].value!));
    }

    if (leftWord.isEmpty && rightWord.isEmpty) return {};

    final string = [...leftWord.reversed, input, ...rightWord];
    if (string.length <= 2) return {};

    final validWords = WordUtils.findValidWordsIncluding(string, input);
    if (validWords == null) return {};

    return validWords.map(WordUtils.indexedLettersToStr).toSet();
  }

  /// Finds all the unique valid and at least 3 character long
  /// English word from some string.
  /// The word will include the given index char
  static Set<List<IndexedLetter>>? findValidWordsIncluding(
    List<IndexedLetter> string,
    IndexedLetter includingLetter,
  ) {
    Set<List<IndexedLetter>> words = {};
    for (var i = 0; i < string.length; i++) {
      for (var j = i + 1; j <= string.length; j++) {
        final characterList = string.sublist(i, j);

        if (characterList.length <= 2) continue;
        if (!characterList.contains(includingLetter)) continue;
        if (!Words.has(indexedLettersToStr(characterList))) continue;

        words.add(characterList);
      }
    }

    if (words.isNotEmpty) return words;
    return null;
  }

  static String indexedLettersToStr(List<IndexedLetter> letters) {
    return letters.fold(
      '',
      (result, current) => result += current.value.toLowerCase(),
    );
  }

  /// Only works for ASCII strings
  static String reverse(String str) => str.split('').reversed.join().toString();
}

class IndexedLetter {
  int index;
  String value;

  IndexedLetter(this.index, this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndexedLetter &&
          runtimeType == other.runtimeType &&
          index == other.index &&
          value == other.value;

  @override
  int get hashCode => index.hashCode ^ value.hashCode;

  @override
  String toString() {
    return 'IndexedLetter{index: $index, value: $value}';
  }
}
