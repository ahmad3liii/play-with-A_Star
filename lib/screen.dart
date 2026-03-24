import 'package:play_with_a_star/a_star.dart';
import 'package:flutter/material.dart';
import 'package:play_with_a_star/node.dart';

void main() {
  runApp(const PathfindingApp());
}

class PathfindingApp extends StatelessWidget {
  const PathfindingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AStarVisualizer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AStarVisualizer extends StatefulWidget {
  const AStarVisualizer({super.key});

  @override
  State<AStarVisualizer> createState() => _AStarVisualizerState();
}

class _AStarVisualizerState extends State<AStarVisualizer> {
  final grid = [
    [0, 0, 0, 0, 1, 0],
    [0, 1, 1, 0, 0, 0],
    [0, 0, 0, 1, 0, 1],
    [0, 1, 0, 0, 0, 0],
    [0, 1, 1, 1, 0, 1],
    [0, 1, 0, 1, 0, 0],
  ];

  List<Node> openSet = [];
  List<Node> closedSet = [];
  List<Node> finalPath = [];

  bool running = false;

  Node? start;
  Node? goal;

  bool selectingStart = false;
  bool selectingGoal = false;

  Future<void> startAlgorithm() async {
    if (start == null || goal == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("الرجاء تحديد البداية والهدف أولاً")),
      );
      return;
    }

    setState(() {
      running = true;
      openSet.clear();
      closedSet.clear();
      finalPath.clear();
    });

    final astar = AStar(grid);

    astar.onStep = (open, closed) {
      setState(() {
        openSet = open;
        closedSet = closed;
      });
    };

    final result = await astar.findPath(start!, goal!);

    setState(() {
      finalPath = result;
      running = false;
    });
  }

  Color cellColor(int x, int y) {
    if (start != null && x == start!.x && y == start!.y) return Colors.yellow;
    if (goal != null && x == goal!.x && y == goal!.y) return Colors.purple;

    if (grid[x][y] == 1) return Colors.grey.shade800;
    if (finalPath.any((n) => n.x == x && n.y == y)) return Colors.green;
    if (openSet.any((n) => n.x == x && n.y == y)) return Colors.blue;
    if (closedSet.any((n) => n.x == x && n.y == y)) return Colors.red;

    return Colors.white;
  }

  void showInfo(int x, int y) {
    Node? node;

    node = openSet.firstWhere(
      (n) => n.x == x && n.y == y,
      orElse: () => closedSet.firstWhere(
        (n) => n.x == x && n.y == y,
        orElse: () => finalPath.firstWhere(
          (n) => n.x == x && n.y == y,
          orElse: () => Node(x, y),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Node ($x,$y)"),
        content: Text(
          "g = ${node!.g}\n"
          "h = ${node.h}\n"
          "f = ${node.f}",
        ),
      ),
    );
  }

  void selectCell(int x, int y) {
    if (grid[x][y] == 1) return;

    setState(() {
      if (selectingStart) {
        start = Node(x, y);
        selectingStart = false;
      } else if (selectingGoal) {
        goal = Node(x, y);
        selectingGoal = false;
      } else {
        showInfo(x, y);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text("A* Visualization"),
        backgroundColor: Colors.amber[50],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: grid.length * grid[0].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: grid[0].length,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemBuilder: (_, i) {
                int x = i ~/ grid[0].length;
                int y = i % grid[0].length;

                return GestureDetector(
                  onTap: () => selectCell(x, y),
                  child: Container(
                    decoration: BoxDecoration(
                      color: cellColor(x, y),
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[100],
                ),
                onPressed: running
                    ? null
                    : () => setState(() {
                        selectingStart = true;
                        selectingGoal = false;
                      }),
                child: const Text("تحديد البداية"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[100],
                ),
                onPressed: running
                    ? null
                    : () => setState(() {
                        selectingGoal = true;
                        selectingStart = false;
                      }),
                child: const Text("تحديد الهدف"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[100],
                ),
                onPressed: running ? null : startAlgorithm,
                child: Text(
                  running ? "جاري التنفيذ..." : "ابدأ",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
