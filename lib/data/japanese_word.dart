import 'package:translator_app/data/word.dart';

class JapaneseWord extends Word {
  final String hiragana;
  JapaneseWord({required word, required mean, required this.hiragana})
      : super(mean: mean, word: word);

  @override
  String toString() {
    return 'JapaneseWord(word: ${super.word}, mean: ${super.mean}, hiragana: $hiragana)';
  }
}
