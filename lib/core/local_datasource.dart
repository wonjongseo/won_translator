import 'package:hive/hive.dart';
import 'package:translator_app/data/word.dart';

class LocalDataSource {
  static Future<void> initialize() async {
    Hive.init("C:/Users/kissco/Desktop/learning/translator_app/assets/hive");

    Hive.registerAdapter(WordAdapter());

    await Hive.openBox<Word>(Word.boxKey);
  }

  Future<bool> hasData() async {
    final list = Hive.box<Word>(Word.boxKey);

    List<Word> words = List.generate(list.length, (index) => list.getAt(index))
        .whereType<Word>()
        .toList();

    return list.isNotEmpty;
  }

  Future<List<Word>> getAllVoca() async {
    final list = Hive.box<Word>(Word.boxKey);

    List<Word> words = List.generate(list.length, (index) => list.getAt(index))
        .whereType<Word>()
        .toList();

    return words;
  }

  void saveVoca(Word word) {
    final list = Hive.box<Word>(Word.boxKey);

    list.put(word.word, word);
  }

  void deleteVoca(Word word) {
    final list = Hive.box<Word>(Word.boxKey);

    list.delete(word.word);
  }

  void updateKnownVoca(Word word) {
    print('word: ${word}');

    final list = Hive.box<Word>(Word.boxKey);
    word.isKnown = !word.isKnown;
    list.put(word.word, word);
  }
}
