import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/constant/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  String _resultDeclare = '';
  static var customFontWhite = GoogleFonts.coiny(
      textStyle:
          const TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 28));
  int oScore = 0;
  int xScore = 0;
  bool winnerFound = false;

  int filledBoxCount = 0;
  static const maxSecond = 30;
  int seconds = maxSecond;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    _timer?.cancel();
  }

  void resetTimer() {
    seconds = maxSecond;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MainColors.primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'PLAYER O',
                            style: customFontWhite,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            oScore.toString(),
                            style: customFontWhite,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            'PLAYER X',
                            style: customFontWhite,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            xScore.toString(),
                            style: customFontWhite,
                          ),
                        ],
                      )
                    ],
                  )),
              Expanded(
                  flex: 3,
                  child: GridView.builder(
                      itemCount: 9,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () => {
                            _tapped(index),
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                    width: 5, color: MainColors.primaryColor),
                                color: MainColors.secondayColor),
                            child: Center(
                              child: Text(
                                displayXO[index],
                                style: GoogleFonts.coiny(
                                    textStyle: TextStyle(
                                        fontSize: 64,
                                        color: MainColors.primaryColor)),
                              ),
                            ),
                          ),
                        );
                      }))),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          _resultDeclare,
                          style: customFontWhite,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white),
                          child: GestureDetector(
                            onTap: () {
                              _clearBoard();
                            },
                            child: Center(
                              child: Text(
                                'Play Again',
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && displayXO[index] == '') {
        displayXO[index] = 'O';
        filledBoxCount++;
      } else if (!oTurn && displayXO[index] == '') {
        displayXO[index] = 'X';
        filledBoxCount++;
      }
      oTurn = !oTurn;

      _checkWinner();
    });
  }

  void _checkWinner() {
    //1st row check

    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        _resultDeclare = 'Player ' + displayXO[0] + ' wins';
        _updateScore(displayXO[0]);
      });
    }
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        _resultDeclare = 'Player ' + displayXO[3] + ' wins';
        _updateScore(displayXO[3]);
      });
    }
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        _resultDeclare = 'Player ' + displayXO[6] + ' wins';
        _updateScore(displayXO[6]);
      });
    }
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        _resultDeclare = 'Player ' + displayXO[0] + ' wins';
        _updateScore(displayXO[0]);
      });
    }

    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        _resultDeclare = 'Player ' + displayXO[1] + ' wins';
        _updateScore(displayXO[1]);
      });
    }

    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        _resultDeclare = 'Player ' + displayXO[2] + ' wins';
        _updateScore(displayXO[2]);
      });
    }

    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        _resultDeclare = 'Player ' + displayXO[0] + ' wins';
        _updateScore(displayXO[0]);
      });
    }

    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') {
      setState(() {
        _resultDeclare = 'Player ' + displayXO[2] + ' wins';
        _updateScore(displayXO[2]);
      });
    }
    if (!winnerFound && filledBoxCount == 9) {
      _resultDeclare = "It's a Tie";
    }
  }

  void _updateScore(String winner) {
    if (winner == 'X') {
      xScore++;
    } else {
      oScore++;
    }

    winnerFound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      _resultDeclare = '';
    });
    filledBoxCount = 0;
  }
}
