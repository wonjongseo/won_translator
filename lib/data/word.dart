class Word {
  final String originalWord;
  final String target1Word;
  final String target2Word;
  final int id;

  const Word(
      {required this.id,
      required this.originalWord,
      required this.target1Word,
      required this.target2Word});

  @override
  String toString() {
    return 'Word(id: $id, originalWord: $originalWord, target1Word: $target1Word, target2Word: $target2Word)';
  }
}
