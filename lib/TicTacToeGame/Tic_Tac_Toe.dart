import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> board = List.filled(9, '');
  bool isXTurn = true;
  bool vsComputer = false;

  @override
  void initState() {
    super.initState();
    loadGame();
  }

  Future<void> saveGame() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('board', board);
    prefs.setBool('isXTurn', isXTurn);
  }

  Future<void> loadGame() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      board = prefs.getStringList('board') ?? List.filled(9, '');
      isXTurn = prefs.getBool('isXTurn') ?? true;
    });
  }

  void resetGame() async {
    setState(() {
      board = List.filled(9, '');
      isXTurn = true;
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void onTap(int index) {
    if (board[index] != '') return;

    setState(() {
      board[index] = isXTurn ? 'X' : 'O';
      isXTurn = !isXTurn;
    });

    saveGame();

    if (vsComputer && !isXTurn) {
      computerMove();
    }
  }

  void computerMove() {
    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        setState(() {
          board[i] = 'O';
          isXTurn = true;
        });
        saveGame();
        break;
      }
    }
  }

  String checkWinner() {
    const wins = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var w in wins) {
      if (board[w[0]] != '' &&
          board[w[0]] == board[w[1]] &&
          board[w[1]] == board[w[2]]) {
        return '${board[w[0]]} Wins!';
      }
    }

    if (!board.contains('')) return 'Draw';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final result = checkWinner();

    return Scaffold(
      appBar: AppBar(title: const Text('Tic Tac Toe')),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Play vs Computer'),
            value: vsComputer,
            onChanged: (value) {
              setState(() {
                vsComputer = value;
                resetGame();
              });
            },
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => result == '' ? onTap(index) : null,
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    color: Colors.blue.shade100,
                    child: Center(
                      child: Text(
                        board[index],
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (result.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                result,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ElevatedButton(
            onPressed: resetGame,
            child: const Text('Restart Game'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
