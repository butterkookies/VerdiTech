import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/engine/ca_engine.dart';
import '../../../domain/models/enums.dart';
import '../../../providers/plant_providers.dart';
import '../../../providers/prediction_providers.dart';

import '../../../presentation/theme/verditech_theme.dart';
import '../../../presentation/theme/vt_a11y.dart';
import '../../../presentation/theme/vt_haptics.dart';
import '../../../presentation/widgets/glass_container.dart';
import '../../../presentation/widgets/stage_chip.dart';
import '../../../presentation/widgets/vt_shimmer.dart';

class CAVisualizationScreen extends ConsumerStatefulWidget {
  final String id;
  const CAVisualizationScreen({super.key, required this.id});

  @override
  ConsumerState<CAVisualizationScreen> createState() => _CAVizState();
}

class _CAVizState extends ConsumerState<CAVisualizationScreen>
    with SingleTickerProviderStateMixin {
  static const int days = 60;
  static const int cells = 24;

  late List<List<GrowthStage>> _history;
  bool _computing = true;
  int _currentDay = 18;
  bool _playing = false;
  ui.Image? _cachedHistoryImage;
  Size? _cachedSize;

  late final AnimationController _ticker = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
  )..addStatusListener((s) {
      if (s == AnimationStatus.completed && _playing) {
        _ticker.reset();
        if (_currentDay < days - 1) {
          setState(() => _currentDay++);
          _ticker.forward();
        } else {
          setState(() => _playing = false);
        }
      }
    });

  @override
  void initState() {
    super.initState();
    _runSimulation();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _cachedHistoryImage?.dispose();
    super.dispose();
  }

  Future<void> _runSimulation() async {
    final sw = Stopwatch()..start();
    
    // Simulate real CA engine call delay
    await Future.delayed(const Duration(milliseconds: 600));

    final plant = ref.read(plantByIdProvider(int.parse(widget.id))).valueOrNull;
    if (plant != null) {
      final engine = const CaEngine();
      final env = ref.read(environmentProfileProvider(plant));
      final forecast = engine.forecast(
        plant: plant,
        environment: env,
        forecastDays: days,
      );
      
      final out = <List<GrowthStage>>[];
      for (int d = 0; d < days; d++) {
        final row = <GrowthStage>[];
        for (int c = 0; c < cells; c++) {
          // Simulate spatial spread from the center
          final distFromCenter = (c - cells ~/ 2).abs();
          final effectiveDay = (d - distFromCenter ~/ 2).clamp(0, days - 1);
          final stage = forecast[effectiveDay].predictedStage;
          row.add(stage);
        }
        out.add(row);
      }
      _history = out;
      _currentDay = plant.daysPlanted.clamp(0, days - 1);
    } else {
      // Fallback if plant missing
      final out = <List<GrowthStage>>[];
      for (int d = 0; d < days; d++) {
        final row = <GrowthStage>[];
        for (int c = 0; c < cells; c++) {
          row.add(GrowthStage.seedling);
        }
        out.add(row);
      }
      _history = out;
      _currentDay = 0;
    }

    sw.stop();
    if (mounted) setState(() => _computing = false);
  }

  Future<void> _rebuildCachedImage(Size size) async {
    if (_computing) return;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    _StaticGridPainter(
      history: _history,
      cells: cells,
      frozenDays: _currentDay,
      totalDays: days,
    ).paint(canvas, size);
    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    _cachedHistoryImage?.dispose();
    if (mounted) setState(() => _cachedHistoryImage = img);
    _cachedSize = size;
  }

  void _togglePlay() {
    if (VTA11y.reduceMotion(context)) {
      setState(() => _currentDay = days - 1);
      return;
    }
    setState(() => _playing = !_playing);
    if (_playing) {
      if (_currentDay >= days - 1) _currentDay = 0;
      _ticker.forward();
    } else {
      _ticker.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    final dominant =
        _computing ? GrowthStage.seedling : _history[_currentDay][cells ~/ 2];

    return Scaffold(
      backgroundColor: s.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: s.textPrimary,
        elevation: 0,
        title: Text(
          'CA Growth Engine',
          style: TextStyle(
              color: s.textPrimary, fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status bar.
            GlassContainer(
              child: Row(
                children: [
                  Icon(dominant.icon, color: dominant.color),
                  const SizedBox(width: VTSpace.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Predicted state',
                            style: TextStyle(
                                color: s.textMuted, fontSize: 12)),
                        Text(
                          'Day ${_currentDay + 1} of $days',
                          style: TextStyle(
                            color: s.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  StageChip(stage: dominant, compact: true),
                ],
              ),
            ),
            const SizedBox(height: VTSpace.lg),

            // Grid area.
            Expanded(
              child: GlassContainer(
                padding: const EdgeInsets.all(VTSpace.sm),
                child: _computing
                    ? const CAComputingSkeleton()
                    : RepaintBoundary(
                        child: LayoutBuilder(
                          builder: (_, box) {
                            final size =
                                Size(box.maxWidth, box.maxHeight);
                            if (_cachedSize != size) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback(
                                      (_) => _rebuildCachedImage(size));
                            }
                            return Semantics(
                              label: 'Cellular automata forecast grid. '
                                  'Day ${_currentDay + 1} of $days. '
                                  'Predicted stage: ${dominant.label}.',
                              child: ExcludeSemantics(
                                child: CustomPaint(
                                  size: size,
                                  isComplex: true,
                                  willChange: _playing,
                                  painter: _LeadingRowPainter(
                                    history: _history,
                                    cells: cells,
                                    currentDay: _currentDay,
                                    totalDays: days,
                                    cachedImage: _cachedHistoryImage,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ),
            const SizedBox(height: VTSpace.lg),

            // Scrubber row.
            Row(
              children: [
                _PlayButton(playing: _playing, color: dominant.color, onTap: _togglePlay),
                const SizedBox(width: VTSpace.md),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: dominant.color,
                      inactiveTrackColor: Colors.white.withOpacity(0.1),
                      thumbColor: dominant.color,
                      overlayColor: dominant.color.withOpacity(0.2),
                    ),
                    child: Slider(
                      value: _currentDay.toDouble(),
                      min: 0,
                      max: (days - 1).toDouble(),
                      onChanged: _computing
                          ? null
                          : (v) {
                              final next = v.round();
                              if (next != _currentDay) {
                                VTHaptics.select();
                              }
                              setState(() {
                                _playing = false;
                                _currentDay = next;
                              });
                            },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: VTSpace.sm),

            // Stage legend.
            Wrap(
              spacing: VTSpace.sm,
              runSpacing: VTSpace.sm,
              children: GrowthStage.values
                  .map((st) => StageChip(stage: st, compact: true))
                  .toList(),
            ),
            const SizedBox(height: VTSpace.md),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Play button
// ---------------------------------------------------------------------------

class _PlayButton extends StatelessWidget {
  final bool playing;
  final Color color;
  final VoidCallback onTap;
  const _PlayButton(
      {required this.playing, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: VTGradients.verdant,
        ),
        child: Icon(
          playing ? Icons.pause : Icons.play_arrow,
          color: Colors.black87,
          size: 28,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Painters
// ---------------------------------------------------------------------------

class _StaticGridPainter extends CustomPainter {
  final List<List<GrowthStage>> history;
  final int cells, frozenDays, totalDays;

  const _StaticGridPainter({
    required this.history,
    required this.cells,
    required this.frozenDays,
    required this.totalDays,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cellW = size.width / cells;
    final cellH = size.height / totalDays;
    final paint = Paint();
    for (int d = 0; d < frozenDays; d++) {
      for (int c = 0; c < cells; c++) {
        paint.color = history[d][c].color.withOpacity(0.85);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
                c * cellW + 1, d * cellH + 1, cellW - 2, cellH - 2),
            const Radius.circular(2),
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_StaticGridPainter o) =>
      o.frozenDays != frozenDays || !identical(o.history, history);
}

class _LeadingRowPainter extends CustomPainter {
  final List<List<GrowthStage>> history;
  final int cells, currentDay, totalDays;
  final ui.Image? cachedImage;

  _LeadingRowPainter({
    required this.history,
    required this.cells,
    required this.currentDay,
    required this.totalDays,
    required this.cachedImage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (cachedImage != null) {
      canvas.drawImage(cachedImage!, Offset.zero, Paint());
    }

    final cellW = size.width / cells;
    final cellH = size.height / totalDays;
    final y = currentDay * cellH;
    final paint = Paint();

    for (int c = 0; c < cells; c++) {
      paint.color = history[currentDay][c].color;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(c * cellW + 1, y + 1, cellW - 2, cellH - 2),
          const Radius.circular(2),
        ),
        paint,
      );
    }

    canvas.drawLine(
      Offset(0, y),
      Offset(size.width, y),
      Paint()
        ..color = Colors.white.withOpacity(0.6)
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(_LeadingRowPainter old) =>
      old.currentDay != currentDay || old.cachedImage != cachedImage;
}
