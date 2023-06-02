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
  var _gameBoard = List.generate(6, (index) => List.generate(7, (index) => _GameBoardButton()));
  var isPlayerOne = true;
  var winner = null;

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
      _gameBoard[i][j].value = isPlayerOne ? _player_2 : _player_1;
      isPlayerOne = !isPlayerOne;
    });
    if (checkForWinner()) {
      setState(() {
        winner = isPlayerOne ? _player_2 : _player_1;
      });
      _showSimpleModalDialog(context);
    }
  }

  _showSimpleModalDialog(context){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(20.0)),
            child: Container(
            constraints: const BoxConstraints(maxHeight: 350),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // show the winner with the IconButton
                      SvgPicture.asset(
                        winner == _player_1 ? 'assets/yellow.svg' : 'assets/red.svg',
                        width: 80,
                        height: 80,
                      ),
                      // show an image from the asset
                      SvgPicture.asset(
                        'assets/winner.svg',
                        width: 150,
                        height: 150,
                      )
                    ]
                  ),
                  Text(
                    '${winner == _player_1 ? 'Yellow' : 'Red'} wins!',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        winner = null;
                        isPlayerOne = true;
                        _gameBoard = List.generate(6, (index) => List.generate(7, (index) => _GameBoardButton()));
                      });
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Play again'),
                  ),
                ],
              )
            ),
          ),
        );
    });
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
            if (_gameBoard[i][j].value == _player_2) {
              asset = 'assets/yellow.svg';
            } else if (_gameBoard[i][j].value == _player_1) {
              asset = 'assets/red.svg';
            }
            return IconButton(
              icon: SvgPicture.asset(
                asset
              ),
              onPressed: () {
                if (winner != null) {
                  return;
                }
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
