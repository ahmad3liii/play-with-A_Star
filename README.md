# A* Pathfinding Visualizer 🚀

A sleek and interactive Flutter application that visualizes the **A_Star Search Algorithm** in real-time. This project demonstrates the implementation of heuristic-based pathfinding, state management in Flutter, and custom data structures like Priority Queues.

## 📌 Features
* **Interactive Grid:** Select custom start and goal points on a 6x6 grid.
* **Real-time Visualization:** Watch the algorithm explore the nodes (Open Set, Closed Set) with a step-by-step animation.
* **Heuristic Logic:** Uses **Manhattan Distance** to calculate the most efficient path.
* **Node Inspection:** Tap on any node to see its calculated values: **g(n)**, **h(n)**, and **f(n)**.
* **Dynamic Obstacles:** Pre-defined obstacles (walls) to test the algorithm's efficiency.

## 🛠️ Tech Stack
* **Framework:** [Flutter](https://flutter.dev)
* **Language:** [Dart](https://dart.dev)
* **Data Structures:** Custom `PriorityQueue` implementation for optimized node selection.

## 🧩 How it Works
1.  **Define Start & Goal:** Use the buttons to toggle selection mode and tap the grid.
2.  **Algorithm Execution:** The visualizer processes nodes based on the formula:
    $$f(n) = g(n) + h(n)$$
    * `g(n)`: Cost from the start node.
    * `h(n)`: Heuristic estimate to the goal.
3.  **Visualization:**
    * 🟦 **Blue:** Nodes in the Open Set.
    * 🟥 **Red:** Nodes in the Closed Set.
    * 🟩 **Green:** The final calculated path.

## 🚀 Getting Started
1. Clone the repository:
   ```bash
   git clone [https://github.com/ahmad3liii/play_with_a_star.git](https://github.com/ahmad3liii/play_with_a_star.git)
