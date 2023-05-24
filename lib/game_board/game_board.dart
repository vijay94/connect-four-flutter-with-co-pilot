import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key, required this.title});

  final String title;

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardButton {
  int value = 0;
}

class _GameBoardState extends State<GameBoard> {
  final _gameBoard = List.generate(6, (index) => List.generate(7, (index) => _GameBoardButton()));
  var isPlayerOne = true;

  // write a function to check for a winner
  bool checkForWinner() {
    // check for horizontal win
    for (var i = 0; i < 6; i++) {
      for (var j = 0; j < 4; j++) {
        if (_gameBoard[i][j].value != 0 &&
            _gameBoard[i][j].value == _gameBoard[i][j + 1].value &&
            _gameBoard[i][j].value == _gameBoard[i][j + 2].value &&
            _gameBoard[i][j].value == _gameBoard[i][j + 3].value) {
          return true;
        }
      }
    }

    // check for vertical win
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 7; j++) {
        if (_gameBoard[i][j].value != 0 &&
            _gameBoard[i][j].value == _gameBoard[i + 1][j].value &&
            _gameBoard[i][j].value == _gameBoard[i + 2][j].value &&
            _gameBoard[i][j].value == _gameBoard[i + 3][j].value) {
          return true;
        }
      }
    }

    // check for diagonal win
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 4; j++) {
        if (_gameBoard[i][j].value != 0 &&
            _gameBoard[i][j].value == _gameBoard[i + 1][j + 1].value &&
            _gameBoard[i][j].value == _gameBoard[i + 2][j + 2].value &&
            _gameBoard[i][j].value == _gameBoard[i + 3][j + 3].value) {
          return true;
        }
      }
    }

    // check for diagonal win
    for (var i = 0; i < 3; i++) {
      for (var j = 3; j < 7; j++) {
        if (_gameBoard[i][j].value != 0 &&
            _gameBoard[i][j].value == _gameBoard[i + 1][j - 1].value &&
            _gameBoard[i][j].value == _gameBoard[i + 2][j - 2].value &&
            _gameBoard[i][j].value == _gameBoard[i + 3][j - 3].value) {
          return true;
        }
      }
    }
    return false;
  }

  void setButton(i, j) {
    setState(() {
      _gameBoard[i][j].value = isPlayerOne ? 1 : 2;
      isPlayerOne = !isPlayerOne;
    });
    print(checkForWinner());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        // create a grid of buttons
        child: GridView.count(
          padding: const EdgeInsets.all(0),
          crossAxisCount: 7,
          crossAxisSpacing: 0.1,
          mainAxisSpacing: 0.1,
          children: List.generate(42, (index) {
            int i = (index / 7).floor();
            var j = index % 7;

            var asset = 'assets/grey.svg';
            if (_gameBoard[i][j].value == 2) {
              asset = 'assets/yellow.svg';
            } else if (_gameBoard[i][j].value == 1) {
              asset = 'assets/red.svg';
            }
            return IconButton(
              icon: SvgPicture.asset(
                asset
              ),
              onPressed: () {
                if (_gameBoard[i][j].value != 0) {
                  return;
                }
                if (i == 5 || _gameBoard[i + 1][j].value != 0) {
                  setButton(i, j);
                }
              },
            );
          }),
        ),
      ),
    );
  }
}
