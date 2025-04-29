import 'dart:io';

import 'package:connect_four/menu_page/menu_page.dart';
import 'package:flutter/material.dart';

import '../game_board/board.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
enum Page {
  menuPage,
  gameBoard,
}

class _MyHomePageState extends State<MyHomePage> {
  // There are two pages in this app: the menu page and the GameBoard page.
  // Maintain the state of current page here.
  // Write a function to switch between pages.

  var _currentPage = Page.menuPage;

  void _switchPage(Page page) {
    setState(() {
      _currentPage = page;
    });
  }

  // Write a function that returns the current page.
  Widget _getCurrentPage() {
    if (_currentPage == Page.menuPage) {
      return MenuPage(title: 'Connect Four', startGame: _switchToGameBoard, exitApp: _exitApp);
    } else {
      return GameBoard(title: 'Connect Four', goToMenuPage: _switchToMenuPage);
    }
  }

  // Write a function that switches to the GameBoard page.
  void _switchToGameBoard() {
    _switchPage(Page.gameBoard);
  }

  // Write a function that exits the app.
  void _exitApp() {
    exit(0);
  }

  // Write a function that switches to the menu page.
  void _switchToMenuPage() {
    _switchPage(Page.menuPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentPage(),
    );
  }
}
