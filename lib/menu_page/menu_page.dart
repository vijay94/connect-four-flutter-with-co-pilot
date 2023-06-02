// Create a widget called MenuPage that extends StatelessWidget.
// The MenuPage widget should get the function to switch pages as a parameter.
// The MenuPage widget should have a title.
// The MenuPage widget should get the title as a parameter.
// The MenuPage widget should have a button to start the game.
// The MenuPage widget should have a button to exit the game.

// Path: lib/menu_page/menu_page.dart
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key, required this.title, required this.startGame, required this.exitApp});

  final String title;
  final Function startGame;
  final Function exitApp;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 100),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 100),
          ElevatedButton(
            onPressed: () {
              startGame();
            },
            child: const Text("Start game"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              exitApp();
            },
            child: const Text("Exit game"),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}