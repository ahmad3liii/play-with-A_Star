class PriorityQueue<T> {
  final List<T> _elements = [];
  final int Function(T, T) _compare;

  PriorityQueue(this._compare);

  void add(T element) {
    _elements.add(element);
    _elements.sort(_compare);
  }

  T removeFirst() => _elements.removeAt(0);

  bool contains(T element) => _elements.contains(element);

  void remove(T element) => _elements.remove(element);

  bool get isEmpty => _elements.isEmpty;
  bool get isNotEmpty => _elements.isNotEmpty;

  List<T> toList() => List.from(_elements);
}
