import 'package:flutter/material.dart';
import 'dart:math';

class CaVisualizationScreen extends StatefulWidget {
  final String id;
  const CaVisualizationScreen({super.key, required this.id});

  @override
  State<CaVisualizationScreen> createState() => _CaVisualizationScreenState();
}

class _CaVisualizationScreenState extends State<CaVisualizationScreen> {
  final int _gridSize = 20;
  List<List<int>> _grid = [];
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    final random = Random();
    _grid = List.generate(
      _gridSize,
      (_) => List.generate(_gridSize, (_) => random.nextInt(3)), // 0: empty, 1: healthy, 2: stressed
    );
  }

  void _simulateStep() {
    final random = Random();
    setState(() {
      for (int i = 0; i < _gridSize; i++) {
        for (int j = 0; j < _gridSize; j++) {
          if (_grid[i][j] != 0) {
            // Randomly change state to simulate CA tick
            _grid[i][j] = random.nextInt(3);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CA Engine Visualization'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '1D Cellular Automata Model Simulation',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _gridSize,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: _gridSize * _gridSize,
                    itemBuilder: (context, index) {
                      final x = index % _gridSize;
                      final y = index ~/ _gridSize;
                      final state = _grid[y][x];

                      Color cellColor;
                      switch (state) {
                        case 1:
                          cellColor = Colors.green;
                          break;
                        case 2:
                          cellColor = Colors.orange;
                          break;
                        default:
                          cellColor = Colors.grey.shade200;
                      }

                      return Container(
                        decoration: BoxDecoration(
                          color: cellColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {
                      _initializeGrid();
                    });
                  },
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                    if (_isPlaying) {
                      _simulateStep();
                    }
                  },
                  child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  onPressed: _simulateStep,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
