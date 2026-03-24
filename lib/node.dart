class Node {
  final int x;
  final int y;
  double g;
  double h;
  double f;
  Node? parent;

  Node(
    this.x,
    this.y, {
    this.g = double.infinity,
    this.h = 0,
    this.f = 0,
    this.parent,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Node && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => "Node($x,$y | g:$g h:$h f:$f)";
}
