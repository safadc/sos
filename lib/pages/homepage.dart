// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:tictactoe/buttonpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String current = "X";
  bool gameOver = false;
  int turn = 0;
  String result = "";
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];

  Game game = Game();
  @override
  void initState() {
    super.initState();
    game.board = Game.initGameBoard();
    // ignore: avoid_print
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Tic Tac Toe ',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'its ${current} turn',
            style: const TextStyle(color: Colors.grey, fontSize: 40),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: boardwidth,
            height: boardwidth,
            child: GridView.count(
              crossAxisCount: Game.boardlenth ~/ 3,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(Game.boardlenth, (index) {
                return InkWell(
                  onTap: gameOver
                      ? null
                      : () {
                          if (game.board![index] == "") {
                            setState(() {
                              game.board![index] = current;
                              turn++;
                              gameOver = game.winnerCheck(
                                  current, index, scoreboard, 3);

                              if (gameOver) {
                                result = "$current is the Winner";
                              } else if (!gameOver && turn == 10) {
                                result = "It's a Draw!";
                                gameOver = true;
                              }
                              if (current == "X")
                                // ignore: curly_braces_in_flow_control_structures
                                current = "O";
                              else

                                // ignore: curly_braces_in_flow_control_structures
                                current = "X";
                            });
                          }
                        },
                  child: Container(
                    width: Game.blocSize,
                    height: Game.blocSize,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        game.board![index],
                        style: TextStyle(
                            color: game.board![index] == "X"
                                ? Colors.blue
                                : Colors.pink,
                            fontSize: 64.0),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            result,
            style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                game.board = Game.initGameBoard();
                current = "X";
                gameOver = false;
                turn = 0;
                result = "";
                scoreboard = [
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                ];
              });
            },
            icon: const Icon(
              Icons.repeat_on_rounded,
              size: 35,
              color: Colors.white,
            ),
            label: const Text("Repeat game"),
          )
        ],
      ),
    );
  }
}
