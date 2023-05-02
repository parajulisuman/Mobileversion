import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {

  int xScore = 0, oScore = 0, cellsFilled = 0;
  bool xTurn = true; // during first game, X will start
  List display = ["", "", "", "", "", "", "", "", ""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
                child: const Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                )
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Text(
                    "Player X - $xScore",
                    style: const TextStyle(
                      fontSize: 40.0,
                    ),
                  ),
                  Text(
                    "Player O - $oScore",
                    style: const TextStyle(
                      fontSize: 40.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    fillCell(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        display[index],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 120,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 40.0),
            child: ElevatedButton(
              onPressed: () {
                clearScore();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
              ),
              child: const Text(
                "Clear Score Board",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void fillCell(int index) {
    bool win;
    if (display[index] != "") {
      return;
    }
    if (xTurn) {
      setState(() {
        display[index] = "X";
      });
    }
    else {
      setState(() {
        display[index] = "O";
      });
    }
    win = checkWin(index);
    if (win) {
      displayWin(display[index]);
    }
    xTurn = !xTurn;
    cellsFilled++;
    if (cellsFilled == 9) {
      displayDraw();
    }
  }

  bool checkWin(int index) {
    if ((display[0] == display[1]) && (display[1] == display[2]) && (display[0] != "")) { // check for col 1
      return true;
    }
    if ((display[3] == display[4]) && (display[4] == display[5]) && (display[3] != "")) { // check for col 2
      return true;
    }
    if ((display[6] == display[7]) && (display[7] == display[8]) && (display[6] != "")) { // check for col 3
      return true;
    }
    if ((display[0] == display[3]) && (display[3] == display[6]) && (display[0] != "")) { // check for row 1
      return true;
    }
    if ((display[1] == display[4]) && (display[4] == display[7]) && (display[1] != "")) { // check for row 2
      return true;
    }
    if ((display[2] == display[5]) && (display[5] == display[8]) && (display[2] != "")) { // check for row 3
      return true;
    }
    if ((display[0] == display[4]) && (display[4] == display[8]) && (display[0] != "")) { // check for diagonal 1
      return true;
    }
    if ((display[2] == display[4]) && (display[4] == display[6]) && (display[2] != "")) { // check for diagonal 2
      return true;
    }
    return false;
  }

  void displayWin(String player) {
    if (player.compareTo("X") == 0) {
      setState(() {
        xScore++;
      });
    }
    else {
      setState(() {
        oScore++;
      });
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Player $player won"),
          actions: [
            ElevatedButton(
              child: const Text("Play Again"),
              onPressed: () {
                clearBoard();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  void displayDraw() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Draw"),
            actions: [
              ElevatedButton(
                child: const Text("Play Again"),
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }

  void clearBoard() {
    setState(() {
      display = ["", "", "", "", "", "", "", "", ""];
    });
  }

  void clearScore() {
    clearBoard();
    setState(() {
      xScore = 0;
      oScore = 0;
    });
  }
}
