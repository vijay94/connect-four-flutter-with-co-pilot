import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _player_1 = 1;
const _player_2 = 2;

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
  // create a 2D array to represent the game board
  var _gameBoard = List.generate(6, (index) => List.generate(7, (index) => _GameBoardButton()));
  var isPlayerOne = true;

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

  void setButton(index) {
    // set the value of the button to the current player
    setState(() {
      _gameBoard[index ~/ 7][index % 7].value = isPlayerOne ? _player_1 : _player_2;
      isPlayerOne = !isPlayerOne;
    });

    // check for a winner
    if (checkForWinner()) {
      // show a dialog to announce the winner
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Winner!'),
            content: Text('Player ${isPlayerOne ? 2 : 1} has won!'),
            actions: [
              TextButton(
                onPressed: () {
                  // reset the game board
                  setState(() {
                    _gameBoard = List.generate(6, (index) => List.generate(7, (index) => _GameBoardButton()));
                    isPlayerOne = true;
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Play Again'),
              ),
            ],
          );
        },
      );
    }
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

            var asset = 'assets/grey.svg';
            // change the asset based on the value of the button
            if (_gameBoard[index ~/ 7][index % 7].value == _player_2) {
              asset = 'assets/yellow.svg';
            } else if (_gameBoard[index ~/ 7][index % 7].value == _player_1) {
              asset = 'assets/red.svg';
            }
            return IconButton(
              icon: SvgPicture.asset(
                asset
              ),
              onPressed: () {
                // don't allow the player to change the value of a button
                if (_gameBoard[index ~/ 7][index % 7].value != 0) {
                  return;
                }
                // dont allow the player to change the value of a button if the button below it doesn't have a value
                if (index ~/ 7 == 5 || _gameBoard[index ~/ 7 + 1][index % 7].value != 0) {
                  setButton(index);
                }
              },
            );
          }),
        ),
      )
    );
  }
}
