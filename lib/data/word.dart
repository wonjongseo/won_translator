// ignore: file_names
class Word {
  final String word;
  final String mean;

  Word({required this.word, required this.mean});

  @override
  String toString() {
    return "MyWord{word: $word, mean: $mean}";
  }
}
