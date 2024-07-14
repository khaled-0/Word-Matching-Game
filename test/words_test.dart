import 'package:test/test.dart';
import 'package:word_matching_game/data/board_state.dart';
import 'package:word_matching_game/data/words.dart';

main() async {
  await Words.init();

  group("Words set loaded", () {
    test('Contains valid word', () => expect(Words.has("word"), true));
    test('Does not have invalid word', () => expect(Words.has("nword"), false));
  });

  group("Word Utils", () {
    test("Reverse string", () => expect(WordUtils.reverse("string"), "gnirts"));
    test(
      "Reverse string",
      () => expect(WordUtils.reverse("string noob"), "boon gnirts"),
    );

    test("IndexedLetter Conversion", () {
      List<IndexedLetter> letters = List.generate(
        8,
        (index) => IndexedLetter(index, "amonguss"[index]),
      );
      expect(WordUtils.indexedLettersToStr(letters), "amonguss");
    });

    List<BoardCell> board = List.generate(100, BoardCell.new);

    test("Find Horizontal Words", () {
      board[62].value = "I";
      board[63].value = "N";
      board[64].value = "H";
      board[65].value = "A";
      board[66].value = "B";
      board[67].value = "I";
      board[68].value = "T";

      expect(
        WordUtils.horizontalWords(board, 62, 10).contains("inhabit"),
        true,
      );
      expect(WordUtils.horizontalWords(board, 65, 10).contains("habit"), true);
      expect(WordUtils.horizontalWords(board, 68, 10).contains("bit"), true);
    });

    test("Find Vertical Words", () {
      board[32].value = "I";
      board[42].value = "N";
      board[52].value = "H";
      board[62].value = "A";
      board[72].value = "B";
      board[82].value = "I";
      board[92].value = "T";

      expect(WordUtils.verticalWords(board, 32, 10).contains("inhabit"), true);
      expect(WordUtils.verticalWords(board, 62, 10).contains("habit"), true);
      expect(WordUtils.verticalWords(board, 92, 10).contains("bit"), true);
    });
  });
}
