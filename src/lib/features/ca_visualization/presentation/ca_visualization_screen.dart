import 'package:flutter/material.dart';
import 'dart:math';

import '../../../domain/engine/ca_engine.dart';
import '../../../domain/models/enums.dart';
import '../../../domain/models/environment_profile.dart';
import '../../../domain/models/plant.dart';

class CaVisualizationScreen extends StatefulWidget {
  final String id;
  const CaVisualizationScreen({super.key, required this.id});

  @override
  State<CaVisualizationScreen> createState() => _CaVisualizationScreenState();
}

class _CaVisualizationScreenState extends State<CaVisualizationScreen> {
  static const int _timelineLength = 60;
  static const int _numRows = 12; // rows show different env conditions

  final _engine = const CaEngine();
  bool _isPlaying = false;
  int _currentStep = 0;

  late final List<List<GrowthStage>> _grid;

  @override
  void initState() {
    super.initState();
    _grid = _buildGrid();
  }

  /// Runs a simulated forecast grid using the CA engine.
  /// Each row is a different initial environmental score (0.2 → 1.0).
  List<List<GrowthStage>> _buildGrid() {
    final grid = <List<GrowthStage>>[];
    for (int row = 0; row < _numRows; row++) {
      final sunScore = 1.0 + (row / (_numRows - 1)) * 4; // 1..5
      final mockPlant = Plant(
        name: 'Mock',
        type: PlantType.tomato,
        plantingDate: DateTime.now().subtract(const Duration(days: 15)),
        currentStage: GrowthStage.seedling,
        sunlightScore: sunScore,
        waterScore: 3,
        soilScore: 3,
        season: Season.malamig,
      );
      final env = EnvironmentProfile(
        sunlight: sunScore,
        water: 3,
        soil: 3,
        season: Season.malamig,
      );
      final forecast = _engine.forecast(
        plant: mockPlant,
        environment: env,
        forecastDays: _timelineLength,
      );
      grid.add(forecast.map((p) => p.predictedStage).toList());
    }
    return grid;
  }

  Color _colorForStage(GrowthStage stage) {
    switch (stage) {
      case GrowthStage.seedling:
        return const Color(0xFFD7E8C0);
      case GrowthStage.youngPlant:
        return const Color(0xFF8BC34A);
      case GrowthStage.flowering:
        return const Color(0xFFFFEB3B);
      case GrowthStage.fruiting:
        return const Color(0xFFFF7043);
      case GrowthStage.harvestReady:
        return const Color(0xFF4CAF50);
    }
  }

  void _stepForward() {
    setState(() {
      _currentStep = (_currentStep + 1) % _timelineLength;
    });
  }

  void _reset() {
    setState(() {
      _currentStep = 0;
      _isPlaying = false;
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
              '1D Cellular Automata — Growth Forecast (Day $_currentStep of $_timelineLength)',
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
          // Legend
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 12,
              children: GrowthStage.values.map((s) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _colorForStage(s),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(s.displayName, style: const TextStyle(fontSize: 11)),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          // CA Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cellWidth = constraints.maxWidth / _timelineLength;
                  final cellHeight = constraints.maxHeight / _numRows;
                  return Stack(
                    children: [
                      // Grid
                      Column(
                        children: List.generate(_numRows, (row) {
                          return Row(
                            children: List.generate(_timelineLength, (col) {
                              final stage = _grid[row][col];
                              return Container(
                                width: cellWidth,
                                height: cellHeight,
                                padding: const EdgeInsets.all(0.5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _colorForStage(stage),
                                    borderRadius: BorderRadius.circular(2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.05),
                                        blurRadius: 1,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          );
                        }),
                      ),
                      // Current day indicator
                      Positioned(
                        left: _currentStep * cellWidth,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: max(cellWidth, 2),
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              '↑ Each row = higher sunlight (bottom=1, top=5). '
              'Rows with better conditions progress through stages faster.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ),
          // Controls
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Reset',
                  onPressed: _reset,
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  heroTag: 'ca_play',
                  onPressed: () {
                    setState(() => _isPlaying = !_isPlaying);
                    if (_isPlaying) _advanceAutomatically();
                  },
                  child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  tooltip: 'Step Forward',
                  onPressed: _stepForward,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _advanceAutomatically() async {
    while (_isPlaying && mounted) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (!mounted) break;
      setState(() {
        _currentStep = (_currentStep + 1) % _timelineLength;
        if (_currentStep == 0) _isPlaying = false;
      });
    }
  }
}
