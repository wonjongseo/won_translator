import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:translator_app/data/myWord.dart';

class MyVocaPage extends StatefulWidget {
  const MyVocaPage({super.key});

  @override
  State<MyVocaPage> createState() => _MyVocaPageState();
}

class _MyVocaPageState extends State<MyVocaPage> {
  List<MyWord> myWords = [
    MyWord(word: 'word1', mean: 'mean1'),
    MyWord(word: 'word2', mean: 'mean2'),
    MyWord(word: 'word3', mean: 'mean3'),
    MyWord(word: 'word4', mean: 'mean4'),
  ];
  @override
  Widget build(BuildContext context) {
    TextEditingController controller1 = TextEditingController();
    TextEditingController controller2 = TextEditingController();
    FocusNode focusNode = FocusNode();

    void saveWord() {
      String word = controller1.text;
      String mean = controller2.text;
      if (word.isEmpty || mean.isEmpty) return;

      MyWord newWord = MyWord(word: word, mean: mean);
      myWords.add(newWord);

      controller1.clear();
      controller2.clear();
      focusNode.requestFocus();
      setState(() {});
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 60),
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 16, bottom: 32, right: 60, left: 60),
            decoration: BoxDecoration(
                color: Color(0xFF00FFC6).withOpacity(0.4),
                borderRadius: BorderRadius.circular(8)),
            child: Form(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      autofocus: true,
                      focusNode: focusNode,
                      onFieldSubmitted: (value) {
                        // sendMessageToPapago(value: value);
                      },
                      controller: controller1,
                      decoration: const InputDecoration(
                          label: Text('WORD'),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF30E3DF)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF30E3DF)),
                          ),
                          labelStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      autofocus: true,
                      onFieldSubmitted: (value) {
                        saveWord();
                        // sendMessageToPapago(value: value);
                      },
                      controller: controller2,
                      decoration: const InputDecoration(
                          label: Text('MEAN'),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF30E3DF)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF30E3DF)),
                          ),
                          labelStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: double.infinity,
                      height: 70,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF30E3DF)),
                        child: Text(
                          'SAVE',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        onPressed: saveWord,
                      )),
                ],
              ),
            ),
          ),
          const Divider(),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    myWords.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    myWords
                                        .removeAt(myWords.length - index - 1);
                                    setState(() {});
                                  },
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: MyWordCard(
                                myWord: myWords[myWords.length - 1 - index]),
                          ),
                        )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyWordCard extends StatelessWidget {
  const MyWordCard({super.key, required this.myWord});

  final MyWord myWord;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(myWord.word),
              content: Text(myWord.mean),
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFF00FFC6).withOpacity(0.4),
        ),
        child: Center(child: Text(myWord.word)),
      ),
    );
  }
}
