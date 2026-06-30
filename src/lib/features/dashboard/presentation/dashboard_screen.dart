import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/enums.dart';
import '../../../domain/models/plant.dart';
import '../../../providers/plant_providers.dart';
import '../../../providers/prediction_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantsAsync = ref.watch(plantsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('VerdiTech Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => context.go('/about'),
            tooltip: 'About VerdiTech',
          ),
        ],
      ),
      body: plantsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading plants: $e')),
        data: (plants) {
          if (plants.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty_pot.png',
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'No plants tracked yet.',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text('Tap the + button to add your first plant.'),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: plants.length,
            itemBuilder: (context, index) =>
                _PlantCard(
                  key: ValueKey(plants[index].id),
                  plant: plants[index],
                ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/add-plant'),
        icon: const Icon(Icons.add),
        label: const Text('Add Plant'),
      ),
    );
  }
}

class _PlantCard extends ConsumerWidget {
  const _PlantCard({super.key, required this.plant});

  final Plant plant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(envScoreProvider(plant));
    final health = HealthStatus.fromScore(score);
    final daysToHarvest = ref.watch(daysToHarvestProvider(plant));

    final healthColor = _colorForHealth(health);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.go('/plant/${plant.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: healthColor.withValues(alpha: 0.2),
                child: Icon(Icons.eco, color: healthColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plant.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.timeline, size: 14),
                        const SizedBox(width: 4),
                        Text(plant.currentStage.displayName,
                            style: const TextStyle(fontSize: 13)),
                        const SizedBox(width: 12),
                        const Icon(Icons.health_and_safety, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          health.displayName,
                          style: TextStyle(fontSize: 13, color: healthColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Day ${plant.daysPlanted} • ~$daysToHarvest days to harvest',
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
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
}
