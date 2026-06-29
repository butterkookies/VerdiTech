import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/enums.dart';
import '../../../domain/models/plant.dart';
import '../../../providers/plant_providers.dart';
import '../../../providers/prediction_providers.dart';

class PlantDetailsScreen extends ConsumerWidget {
  final String id;
  const PlantDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantAsync = ref.watch(plantByIdProvider(int.parse(id)));

    return plantAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text('Failed to load plant: $e')),
      ),
      data: (plant) {
        if (plant == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Not Found')),
            body: const Center(child: Text('Plant not found.')),
          );
        }
        return _PlantDetailsContent(plant: plant, rawId: id);
      },
    );
  }
}

class _PlantDetailsContent extends ConsumerWidget {
  const _PlantDetailsContent({required this.plant, required this.rawId});

  final Plant plant;
  final String rawId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final envScore = ref.watch(envScoreProvider(plant));
    final health = HealthStatus.fromScore(envScore);
    final recommendations = ref.watch(recommendationsProvider(plant));
    final daysToHarvest = ref.watch(daysToHarvestProvider(plant));
    final forecast = ref.watch(forecastProvider(plant));

    final healthColor = _colorForHealth(health);

    return Scaffold(
      appBar: AppBar(
        title: Text(plant.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            tooltip: 'CA Visualization',
            onPressed: () => context.go('/plant/$rawId/visualization'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Health card
            Card(
              color: healthColor.withValues(alpha: 0.1),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: healthColor.withValues(alpha: 0.5)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Icon(Icons.health_and_safety,
                        size: 48, color: healthColor),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Overall Health'),
                        Text(
                          health.displayName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: healthColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          'Score: ${(envScore * 100).toStringAsFixed(0)}% | '
                          '~$daysToHarvest days to harvest',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Predicted Growth Timeline
            Text(
              'Predicted Growth Timeline',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...GrowthStage.values.where((s) => s != GrowthStage.harvestReady).map(
              (stage) {
                final stageEntry = forecast.firstWhere(
                  (p) => p.predictedStage == stage,
                  orElse: () => forecast.last,
                );
                final isCurrentOrFuture =
                    stage.stageIndex >= plant.currentStage.stageIndex;
                final isCurrent = stage == plant.currentStage;
                return _buildTimelineItem(
                  context,
                  title: stage.displayName,
                  subtitle: isCurrent
                      ? 'Current Stage (Day ${plant.daysPlanted})'
                      : isCurrentOrFuture
                          ? 'Day ~${stageEntry.dayOffset}'
                          : 'Completed',
                  icon: isCurrent
                      ? Icons.adjust
                      : isCurrentOrFuture
                          ? Icons.radio_button_unchecked
                          : Icons.check_circle,
                  color: isCurrent
                      ? Colors.blue
                      : isCurrentOrFuture
                          ? Colors.grey
                          : Colors.green,
                );
              },
            ),
            const SizedBox(height: 32),

            // Recommendations
            Text(
              'Recommendations',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (recommendations.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle,
                          color: Colors.green.shade600),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'All conditions are optimal! Keep up the great work.',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...recommendations.map(
                (rec) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _buildRecommendationCard(context, rec.category,
                      rec.message, _iconForCategory(rec.category)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _colorForHealth(HealthStatus h) {
    switch (h) {
      case HealthStatus.excellent:
        return Colors.green;
      case HealthStatus.good:
        return Colors.lightGreen;
      case HealthStatus.fair:
        return Colors.orange;
      case HealthStatus.poor:
        return Colors.deepOrange;
      case HealthStatus.critical:
        return Colors.red;
    }
  }

  IconData _iconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'watering':
        return Icons.water_drop;
      case 'sunlight':
        return Icons.wb_sunny;
      case 'soil':
        return Icons.grass;
      default:
        return Icons.info_outline;
    }
  }

  Widget _buildTimelineItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 4),
              Container(width: 2, height: 30, color: Colors.grey.shade300),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(
    BuildContext context,
    String title,
    String body,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(body),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
