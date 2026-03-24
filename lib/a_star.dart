import 'package:play_with_a_star/node.dart';
import 'package:play_with_a_star/priority_queue.dart';

class AStar {
  final List<List<int>> grid;

  Function(List<Node> open, List<Node> closed)? onStep;

  AStar(this.grid);

  double _heuristic(Node a, Node b) {
    return (a.x - b.x).abs() + (a.y - b.y).abs().toDouble();
  }

  List<Node> getNeighbors(Node node) {
    final dirs = [
      [1, 0],
      [-1, 0],
      [0, 1],
      [0, -1],
    ];

    List<Node> neighbors = [];
    for (var d in dirs) {
      int nx = node.x + d[0];
      int ny = node.y + d[1];

      if (nx >= 0 &&
          nx < grid.length &&
          ny >= 0 &&
          ny < grid[0].length &&
          grid[nx][ny] == 0) {
        neighbors.add(Node(nx, ny));
      }
    }
    return neighbors;
  }

  Future<List<Node>> findPath(Node start, Node goal) async {
    final openSet = PriorityQueue<Node>((a, b) => a.f.compareTo(b.f));
    final closedSet = <Node>{};
    final nodeMap = <Node, Node>{};

    nodeMap[start] = start;

    start.g = 0;
    start.h = _heuristic(start, goal);
    start.f = start.h;
    openSet.add(start);

    while (openSet.isNotEmpty) {
      Node current = openSet.removeFirst();

      if (current == goal) {
        return _reconstructPath(current);
      }

      closedSet.add(current);

      onStep?.call(openSet.toList(), closedSet.toList());
      await Future.delayed(const Duration(milliseconds: 250));

      for (var neighborPos in getNeighbors(current)) {
        Node neighbor = nodeMap.putIfAbsent(neighborPos, () => neighborPos);

        if (closedSet.contains(neighbor)) continue;

        double tentativeG = current.g + 1;

        if (!openSet.contains(neighbor) || tentativeG < neighbor.g) {
          neighbor.parent = current;
          neighbor.g = tentativeG;
          neighbor.h = _heuristic(neighbor, goal);
          neighbor.f = neighbor.g + neighbor.h;

          if (!openSet.contains(neighbor)) {
            openSet.add(neighbor);
          }
        }
      }
    }

    return [];
  }

  List<Node> _reconstructPath(Node current) {
    List<Node> path = [];
    Node? cur = current;

    while (cur != null) {
      path.add(cur);
      cur = cur.parent;
    }
    return path.reversed.toList();
  }
}
