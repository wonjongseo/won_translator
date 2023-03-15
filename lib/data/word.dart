// ignore: file_names

import 'package:hive/hive.dart';

part 'word.g.dart';

@HiveType(typeId: 0)
class Word {
  static String boxKey = 'word';
  @HiveField(0)
  final String word;
  @HiveField(1)
  final String mean;
  @HiveField(2)
  bool isKnown = false;

  Word({required this.word, required this.mean});

  @override
  String toString() {
    return "MyWord{word: $word, mean: $mean, isKnown: $isKnown}";
  }
}
