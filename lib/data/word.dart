class Word {
  final String originalWord;
  final String target1Word;
  final String target2Word;
  final String originalLan;
  final String target1Lan;
  final String target2Lan;
  const Word(
      {required this.originalLan,
      required this.target1Lan,
      required this.target2Lan,
      required this.originalWord,
      required this.target1Word,
      required this.target2Word});

  @override
  String toString() {
    return 'Word(originalWord: $originalWord, target1Word: $target1Word, target2Word: $target2Word, originalLan: $originalLan, target1Lan: $target1Lan, target2Lan: $target2Lan )';
  }

  List<String> getEnglish() {
    if (originalLan == 'EN') {
      return [originalWord, target1Word, target2Word];
    } else if (target1Lan == 'EN') {
      return [target1Word, originalWord, target2Word];
    } else {
      return [target2Word, target1Word, originalWord];
    }
  }
}
