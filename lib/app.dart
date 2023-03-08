import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:translator_app/screen/my_voca/my_voca_page.dart';
import 'package:translator_app/screen/translator/translator_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Widget> _items = [const MyVocaPage(), const TranslatorPage()];
  int _index = 0;

  void _onTap(int index) {
    print('index: ${index}');
    _index = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _items[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        elevation: 0,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '')
        ],
      ),
    );
  }
}
