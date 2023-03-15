import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:translator_app/core/local_datasource.dart';
import 'package:translator_app/data/word.dart';

class MyVocaPage extends StatefulWidget {
  const MyVocaPage({super.key});

  @override
  State<MyVocaPage> createState() => _MyVocaPageState();
}

class _MyVocaPageState extends State<MyVocaPage> {
  List<Word> myWords = [];
  List<bool> isKnwonWords = [];
  bool isReFresh = false;
  bool isWordFlip = false;
  LocalDataSource localDataSource = LocalDataSource();
  late TextEditingController controller1;
  late TextEditingController controller2;
  late TextEditingController controller3;

  late FocusNode focusNode;

  void loadData() async {
    myWords = await localDataSource.getAllVoca();
    print('myWords: ${myWords}');

    isReFresh = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();

    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller2.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void deleteWord(int index) {
    localDataSource.deleteVoca(myWords[myWords.length - index - 1]);
    myWords.removeAt(myWords.length - index - 1);
  }

  void updateWord(int index) {
    localDataSource.updateKnownVoca(myWords[myWords.length - index - 1]);
    myWords[myWords.length - index - 1].isKnown =
        !myWords[myWords.length - index - 1].isKnown;
  }

  void saveWord() async {
    String word = controller1.text;
    String mean = controller2.text;
    if (word.isEmpty || mean.isEmpty) return;

    Word newWord = Word(word: word, mean: mean);
    myWords.add(newWord);

    localDataSource.saveVoca(newWord);

    controller1.clear();
    controller2.clear();
    focusNode.requestFocus();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 60),
      child: !isReFresh
          ? CircularProgressIndicator()
          : Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 16, bottom: 32, right: 60, left: 60),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Form(
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                enabled: isReFresh,
                                autofocus: true,
                                focusNode: focusNode,
                                onFieldSubmitted: (value) {
                                  // sendMessageToPapago(value: value);
                                },
                                controller: controller1,
                                decoration: InputDecoration(
                                    label: const Text('WORD'),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black.withOpacity(0.2)),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelStyle:
                                        const TextStyle(color: Colors.black)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                enabled: isReFresh,
                                onFieldSubmitted: (value) {
                                  saveWord();
                                  // sendMessageToPapago(value: value);
                                },
                                controller: controller2,
                                decoration: InputDecoration(
                                    label: const Text('MEAN'),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black.withOpacity(0.2)),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelStyle:
                                        const TextStyle(color: Colors.black)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                                width: double.infinity,
                                height: 70,
                                child: !isReFresh
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white),
                                        child: Text(
                                          'REFRESH',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30),
                                        ),
                                        onPressed: () {
                                          loadData();
                                          isReFresh = true;
                                          setState(() {});
                                        },
                                      )
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white),
                                        child: Icon(
                                          Icons.ads_click,
                                          color: Colors.black,
                                        ),
                                        onPressed: saveWord,
                                      )),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(myWords.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Slidable(
                                  startActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          updateWord(
                                              myWords.length - index - 1);
                                          myWords[myWords.length - index - 1]
                                              .isKnown = !myWords[
                                                  myWords.length - index - 1]
                                              .isKnown;
                                          setState(() {});
                                        },
                                        backgroundColor: Colors.grey,
                                        foregroundColor: Colors.white,
                                        icon: Icons.check,
                                        label: 'Unkown',
                                      ),
                                    ],
                                  ),
                                  endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          deleteWord(
                                              myWords.length - index - 1);

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
                                      isWordFlip: isWordFlip,
                                      myWord:
                                          myWords[myWords.length - 1 - index]),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    child: IconButton(
                  icon: Icon(Icons.flip),
                  onPressed: () {
                    isWordFlip = !isWordFlip;
                    setState(() {});
                  },
                )),
              ],
            ),
    );
  }
}

class MyWordCard extends StatelessWidget {
  const MyWordCard({
    super.key,
    required this.myWord,
    required this.isWordFlip,
  });

  final Word myWord;
  final bool isWordFlip;

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
            border: Border.all(width: 1, color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: myWord.isKnown
                    ? Colors.grey.withOpacity(0.7)
                    : Colors.white,
                offset: Offset(0, 1),
              )
            ]),
        child: Center(child: Text(isWordFlip ? myWord.mean : myWord.word)),
      ),
    );
  }
}
