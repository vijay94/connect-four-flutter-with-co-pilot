import 'package:connect_four/home-page/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ConnectFourApp());
}

class ConnectFourApp extends StatelessWidget {
  const ConnectFourApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connect four',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black12,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Connect four game'),
    );
  }
}
