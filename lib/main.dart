import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Velha',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Jogo da Velha'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> board = List.filled(9, '');
  bool isXTurn = true;

  String? getWinner() {
    const List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combination in winningCombinations) {
      final a = combination[0];
      final b = combination[1];
      final c = combination[2];

      if (board[a] == board[b] &&
          board[b] == board[c] &&
          board[a].isNotEmpty) {
        return board[a];
      }
    }

    if (!board.contains('')) {
      return 'Empate';
    }

    return null;
  }

  void resetBoard() {
    setState(() {
      board = List.filled(9, '');
      isXTurn = true;
    });
  }

  void handleTap(int index) {
    if (board[index].isEmpty && getWinner() == null) {
      setState(() {
        board[index] = isXTurn ? 'X' : 'O';
        isXTurn = !isXTurn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final winner = getWinner();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: board.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => handleTap(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      board[index],
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          if (winner != null)
            Column(
              children: [
                Text(
                  winner == 'Empate' ? 'Empate!' : 'Vencedor: $winner',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: resetBoard,
                  child: const Text('Reiniciar Jogo'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
