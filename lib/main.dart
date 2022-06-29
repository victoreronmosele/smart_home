import 'package:flutter/material.dart';
import 'package:smart_home/ui/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.black,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.black)),
      home: const HomeScreen(),
    );
  }
}
