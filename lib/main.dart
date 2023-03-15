import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:translator_app/app.dart';
import 'package:translator_app/core/local_datasource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalDataSource.initialize();

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
      home: const App(),
    );
  }
}

final List<String> languages = ['KO', 'EN', 'JP'];
