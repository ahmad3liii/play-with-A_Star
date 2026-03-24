// import 'package:play_with_a_star/a_star.dart';
// import 'package:play_with_a_star/node.dart';

// Future<void> main() async {
//   List<List<int>> grid = [
//     [0, 0, 0, 0, 0],
//     [0, 1, 1, 1, 0],
//     [0, 0, 0, 1, 0],
//     [1, 1, 0, 0, 0],
//     [0, 0, 0, 1, 0],
//   ];

//   AStar astar = AStar(grid);

//   Node start = Node(0, 0);
//   Node goal = Node(4, 4);

//   List<Node> path = await astar.findPath(start, goal);

//   if (path.isNotEmpty) {
//     for (var n in path) {
//       print("(${n.x}, ${n.y})");
//     }
//   } else {
//     print("No path found");
//   }
// }
