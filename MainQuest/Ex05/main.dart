import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MinesweeperApp());
}

class MinesweeperApp extends StatelessWidget {
  const MinesweeperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minesweeper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MinesweeperGame(),
    );
  }
}

class MinesweeperGame extends StatefulWidget {
  const MinesweeperGame({super.key});

  @override
  _MinesweeperGameState createState() => _MinesweeperGameState();
}

class _MinesweeperGameState extends State<MinesweeperGame> {
  static const int rows = 25;
  static const int cols = 25;
  static const int numMines = 50;

  late List<List<Cell>> grid;
  late DateTime startTime;
  List<int> ranking = [];

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    grid = List.generate(rows, (row) => List.generate(cols, (col) => Cell()));
    placeMines();
    calculateNumbers();
    startTime = DateTime.now(); // 게임 시작 시간 기록
  }

  void placeMines() {
    var random = Random();
    int placedMines = 0;
    while (placedMines < numMines) {
      int row = random.nextInt(rows);
      int col = random.nextInt(cols);
      if (!grid[row][col].hasMine) {
        grid[row][col].hasMine = true;
        placedMines++;
      }
    }
  }

  void calculateNumbers() {
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        if (grid[row][col].hasMine) continue;
        int count = 0;
        for (int i = -1; i <= 1; i++) {
          for (int j = -1; j <= 1; j++) {
            int newRow = row + i;
            int newCol = col + j;
            if (newRow >= 0 &&
                newRow < rows &&
                newCol >= 0 &&
                newCol < cols &&
                grid[newRow][newCol].hasMine) {
              count++;
            }
          }
        }
        grid[row][col].mineCount = count;
      }
    }
  }

  void revealCell(int row, int col) {
    if (grid[row][col].isRevealed || grid[row][col].isFlagged) return;
    setState(() {
      grid[row][col].isRevealed = true;
      var random = Random();
      if (grid[row][col].mineCount == 0 && !grid[row][col].hasMine) {
        for (int i = -1; i <= 1; i++) {
          for (int j = -1; j <= 1; j++) {
            int newRow = row + i;
            int newCol = col + j;
            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols) {
              if (random.nextInt(10) == 0) {
                revealCell(newRow, newCol);
              }
            }
          }
        }
      }
    });
  }

  void gameOver() {
    DateTime endTime = DateTime.now();
    int elapsedSeconds = endTime.difference(startTime).inSeconds;
    ranking.add(elapsedSeconds);
    ranking.sort();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: const Text('You hit a mine!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              resetGame();
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      initializeGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    double cellSize = MediaQuery.of(context).size.width / cols;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minesweeper'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetGame,
          ),
          IconButton(
            icon: const Icon(Icons.leaderboard),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RankingPage(ranking: ranking),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: cols,
        children: List.generate(rows * cols, (index) {
          int row = index ~/ cols;
          int col = index % cols;
          Cell cell = grid[row][col];
          return GestureDetector(
            onTap: () {
              if (cell.hasMine) {
                gameOver();
              } else {
                revealCell(row, col);
              }
            },
            onLongPress: () {
              setState(() {
                cell.isFlagged = !cell.isFlagged;
              });
            },
            child: Container(
              width: cellSize,
              height: cellSize,
              margin: const EdgeInsets.all(1.0),
              color: cell.isRevealed
                  ? (cell.hasMine ? Colors.red : Colors.grey[300])
                  : Colors.blue,
              child: Center(
                child: Text(
                  cell.isRevealed
                      ? (cell.hasMine
                          ? '💣'
                          : cell.mineCount > 0
                              ? '${cell.mineCount}'
                              : '')
                      : (cell.isFlagged ? '🚩' : ''),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class RankingPage extends StatelessWidget {
  final List<int> ranking;

  const RankingPage({super.key, required this.ranking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking'),
      ),
      body: ListView.builder(
        itemCount: ranking.length,
        itemBuilder: (context, index) {
          final time = ranking[index];
          final formattedTime = DateFormat('mm:ss')
              .format(DateTime.fromMillisecondsSinceEpoch(time * 1000));
          return ListTile(
            title: Text('Rank ${index + 1}'),
            subtitle: Text('Time: $formattedTime'),
          );
        },
      ),
    );
  }
}

class Cell {
  bool hasMine = false;
  bool isRevealed = false;
  bool isFlagged = false;
  int mineCount = 0;
}
