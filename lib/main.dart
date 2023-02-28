import 'dart:math';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translator_app/core/network.dart';
import 'package:translator_app/data/word.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePageSceen(),
    );
  }
}

final List<String> languages = ['KO', 'EN', 'JP'];

class HomePageSceen extends StatefulWidget {
  const HomePageSceen({super.key});

  @override
  State<HomePageSceen> createState() => _HomePageSceenState();
}

class _HomePageSceenState extends State<HomePageSceen> {
  List<Word> words = [];
  late TextEditingController controller;
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  NetWork netWork = NetWork();
  String word1 = '';
  String word2 = '';
  bool isWord1Wait = false;
  bool isWord2Wait = false;
  String language1 = 'KO';
  String language2 = 'EN';
  String language3 = 'JP';

  // onTap: () {
  //           focusNode.requestFocus();
  //         },

  void copyText(String word) {
    Clipboard.setData(ClipboardData(text: word));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Copied $word !'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: language1,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      language1 = newVal!;

                      setState(() {});
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Material(
                          child: TextFormField(
                            focusNode: focusNode,
                            autofocus: true,
                            onFieldSubmitted: (value) {
                              sendMessageToPapago(value: value);
                            },
                            controller: controller,
                            decoration:
                                const InputDecoration(hintText: 'input'),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        sendMessageToPapago();
                      },
                      //
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        controller.clear();
                        focusNode.requestFocus();
                      },
                    ),
                  ],
                ),
                // translator
                if (word1 == '' &&
                    word2 == '' &&
                    !(isWord1Wait == true || isWord2Wait == true))
                  const SizedBox(height: 70),

                isWord1Wait == true || isWord2Wait == true
                    ? Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 15),
                              if (word1 != '')
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                          onTap: () => copyText(word1),
                                          child: Text(word1)),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          controller.text = word1;

                                          switch (language2) {
                                            case 'KO':
                                              language1 = 'KO';
                                              break;
                                            case 'EN':
                                              language1 = 'EN';
                                              break;
                                            case 'JP':
                                              language1 = 'JP';
                                              break;
                                          }
                                          setState(() {
                                            sendMessageToPapago();
                                          });
                                        },
                                        icon: const Icon(Icons.send))
                                  ],
                                ),
                              const SizedBox(height: 15),
                              if (word2 != '')
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () => copyText(word2),
                                        child: Text(word2),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          controller.text = word2;

                                          switch (language3) {
                                            case 'KO':
                                              language1 = 'KO';
                                              break;
                                            case 'EN':
                                              language1 = 'EN';
                                              break;
                                            case 'JP':
                                              language1 = 'JP';
                                              break;
                                          }
                                          sendMessageToPapago();
                                        },
                                        icon: const Icon(Icons.send))
                                  ],
                                ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Divider(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          words.length,
                          (index) => Slidable(
                                endActionPane: ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        words
                                            .removeAt(words.length - index - 1);
                                        setState(() {});
                                      },
                                      backgroundColor: Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        margin:
                                            const EdgeInsets.only(bottom: 20.0),
                                        child: TextButton(
                                          child: Text(
                                              words[words.length - index - 1]
                                                  .originalWord),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(words[
                                                          words.length -
                                                              index -
                                                              1]
                                                      .originalWord),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Text(words[
                                                                words.length -
                                                                    index -
                                                                    1]
                                                            .target1Word),
                                                        const SizedBox(
                                                            height: 30),
                                                        Text(words[
                                                                words.length -
                                                                    index -
                                                                    1]
                                                            .target2Word),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.remove))
                                  ],
                                ),
                              )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendMessageToPapago({value}) async {
    if (controller.text.isEmpty) return;

    setState(() {
      isWord1Wait = true;
      isWord2Wait = true;
    });
    Random random = Random();

    // word1 =
    //     '텍스트 필드 컨테이너에는 채우기 및 스트로크가 있습니다(전체 컨테이너 주변 또는 하단 가장자리에만 해당).스트로크의 색상과 두께를 변경하여 텍스트 필드가 활성화된 시점을 나타낼 수 있습니다.텍스트 필드 컨테이너에는 채우기 및 스트로크가 있습니다(전체 컨테이너 주변 또는 하단 가장자리에만 해당).스트로크의 색상과 두께를 변경하여 텍스트 필드가 활성화된 시점을 나타낼 수 있습니다.텍스트 필드 컨테이너에는 채우기 및 스트로크가 있습니다(전체 컨테이너 주변 또는 하단 가장자리에만 해당).스트로크의 색상과 두께를 변경하여 텍스트 필드가 활성화된 시점을 나타낼 수 있습니다.텍스트 필드 컨테이너에는 채우기 및 스트로크가 있습니다(전체 컨테이너 주변 또는 하단 가장자리에만 해당).스트로크의 색상과 두께를 변경하여 텍스트 필드가 활성화된 시점을 나타낼 수 있습니다.텍스트 필드 컨테이너에는 채우기 및 스트로크가 있습니다(전체 컨테이너 주변 또는 하단 가장자리에만 해당).스트로크의 색상과 두께를 변경하여 텍스트 필드가 활성화된 시점을 나타낼 수 있습니다.텍스트 필드 컨테이너에는 채우기 및 스트로크가 있습니다(전체 컨테이너 주변 또는 하단 가장자리에만 해당).스트로크의 색상과 두께를 변경하여 텍스트 필드가 활성화된 시점을 나타낼 수 있습니다.텍스트 필드 컨테이너에는 채우기 및 스트로크가 있습니다(전체 컨테이너 주변 또는 하단 가장자리에만 해당).스트로크의 색상과 두께를 변경하여 텍스트 필드가 활성화된 시점을 나타낼 수 있습니다.텍스트 필드 컨테이너에는 채우기 및 스트로크가 있습니다(전체 컨테이너 주변 또는 하단 가장자리에만 해당).스트로크의 색상과 두께를 변경하여 텍스트 필드가 활성화된 시점을 나타낼 수 있습니다.텍스트 필드 컨테이너에는 채우기 및 스트로크가 있습니다(전체 컨테이너 주변 또는 하단 가장자리에만 해당).스트로크의 색상과 두께를 변경하여 텍스트 필드가 활성화된 시점을 나타낼 수 있습니다.텍스트 필드 컨테이너에는 채우기 및 스트로크가 있습니다(전체 컨테이너 주변 또는 하단 가장자리에만 해당).스트로크의 색상과 두께를 변경하여 텍스트 필드가 활성화된 시점을 나타낼 수 있습니다.텍스트 필드 컨테이너에는 채우기 및 스트로크가 있습니다(전체 컨테이너 주변 또는 하단 가장자리에만 해당).스트로크의 색상과 두께를 변경하여 텍스트 필드가 활성화된 시점을 나타낼 수 있습니다.';
    // word2 =
    //     'テキストフィールドコンテナには塗りつぶしとストロークがあります（コンテナ全体の周囲または下端のみ）。 ストロークの色と太さは、テキストフィールドがアクティブなときに表示されるように変更できます。 ${random.nextInt(100).toString()}';
    switch (language1) {
      // 'KO', 'EN', 'JP'
      case 'KO':
        word1 = await netWork.getWordMean(
            source: 'ko', target: 'ja', word: controller.text);

        word2 =
            await netWork.getWordMean(source: 'ja', target: 'en', word: word1);

        language2 = 'JP';
        language3 = 'EN';
        break;

      case 'EN':
        word1 = await netWork.getWordMean(
            source: 'en', target: 'ko', word: controller.text);

        language2 = 'KO';

        word2 = await netWork.getWordMean(
            source: 'en', target: 'ja', word: controller.text);

        language3 = 'JP';
        break;
      case 'JP':
        word1 = await netWork.getWordMean(
            source: 'ja', target: 'ko', word: controller.text);

        language2 = 'KO';

        word2 = await netWork.getWordMean(
            source: 'ja', target: 'en', word: controller.text);

        language3 = 'EN';
        break;
    }

    setState(() {
      isWord1Wait = false;
      isWord2Wait = false;
    });
    words.add(Word(
        originalWord: controller.text, target1Word: word1, target2Word: word2));
    // words.add(Word(
    //     id: words.length + 1,
    //     originalWord:
    //         'A text field container has a fill and a stroke (either around the entire container, or just the bottom edge). The color and thickness of a stroke can change to indicate when the text field is active.',
    //     target1Word: word1,
    //     target2Word: word2));
  }
}
