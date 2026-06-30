import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/enums.dart';
import '../../../domain/models/plant.dart';
import '../../../providers/plant_providers.dart';
import '../../../providers/prediction_providers.dart';
import '../../../providers/database_provider.dart';

import '../../../presentation/theme/verditech_theme.dart';
import '../../../presentation/theme/vt_haptics.dart';
import '../../../presentation/theme/vt_a11y.dart';
import '../../../presentation/widgets/health_summary_header.dart';
import '../../plant_form/presentation/add_plant_sheet.dart';
import '../../plant_form/presentation/edit_plant_sheet.dart';
import '../../../presentation/widgets/plant_card.dart';
import '../../../presentation/widgets/vt_illustrations.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = VTTheme.of(context);
    final plantsAsync = ref.watch(plantsStreamProvider);
    final reduce = VTA11y.reduceMotion(context);

    return Scaffold(
      backgroundColor: s.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('VerdiTech Dashboard', style: TextStyle(color: s.textPrimary)),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: s.textPrimary),
            onPressed: () => context.go('/about'),
            tooltip: 'About VerdiTech',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: s.verdantDeep,
        onPressed: () async {
          VTHaptics.select();
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const AddPlantSheet(),
          );
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Plant'),
      ),
      body: plantsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading plants: $e', style: const TextStyle(color: Colors.red))),
        data: (plants) {
          if (plants.isEmpty) {
             return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 120),
                  EmptyState(onAdd: () async {
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => const AddPlantSheet(),
                    );
                  }),
                ],
             );
          }

          // Compute aggregates
          double totalScore = 0;
          int needsAttention = 0;
          for (final p in plants) {
            final score = ref.watch(envScoreProvider(p));
            totalScore += score;
            if (HealthStatus.fromScore(score) == HealthStatus.critical || HealthStatus.fromScore(score) == HealthStatus.poor) {
              needsAttention++;
            }
          }
          final overallHealth = totalScore / plants.length;

          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: HealthSummaryHeader(
                  plantCount: plants.length,
                  needAttention: needsAttention,
                  healthScore: overallHealth,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                  child: Text(
                    'Your Plants',
                    style: TextStyle(
                      color: s.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: VTSpace.md,
                    crossAxisSpacing: VTSpace.md,
                    childAspectRatio: 0.82,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final p = plants[i];
                      final envScore = ref.watch(envScoreProvider(p));

                      final card = Dismissible(
                        key: ValueKey(p.id),
                        direction: DismissDirection.up,
                        confirmDismiss: (_) => _confirmDelete(context, ref, p),
                        background: _DeleteBackground(),
                        child: GestureDetector(
                          onLongPress: () => _showActions(context, ref, p),
                          child: PlantCard(
                            name: p.name,
                            species: p.type.displayName,
                            stage: p.currentStage,
                            progressToNext: envScore, 
                            dayInCycle: p.daysPlanted,
                            onTap: () {
                              VTHaptics.select();
                              context.go('/plant/${p.id}');
                            },
                          ),
                        ),
                      );

                      if (reduce) return card;
                      return card
                          .animate()
                          .fadeIn(
                            delay: (80 * i).ms,
                            duration: 400.ms,
                            curve: Curves.easeOut,
                          )
                          .slideY(
                              begin: 0.18,
                              end: 0,
                              curve: Curves.easeOutCubic);
                    },
                    childCount: plants.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DeleteBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: VTColors.fruiting.withOpacity(0.18),
          borderRadius: BorderRadius.circular(VTSpace.radius),
        ),
        child: const Icon(Icons.delete_outline, color: VTColors.fruiting),
      );
}

Future<bool> _confirmDelete(BuildContext context, WidgetRef ref, Plant p) async {
  final s = VTTheme.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: s.surface,
      title: Text('Remove ${p.name}?', style: TextStyle(color: s.textPrimary)),
      content: Text(
        'This stops tracking and discards its forecast. This can\'t be undone.',
        style: TextStyle(color: s.textMuted),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Cancel', style: TextStyle(color: s.textMuted)),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: VTColors.fruiting),
          onPressed: () async {
            VTHaptics.warn();
            await ref.read(plantRepositoryProvider).deletePlant(p.id!);
            if (context.mounted) Navigator.pop(context, true);
          },
          child: const Text('Remove'),
        ),
      ],
    ),
  );
  return ok == true;
}

void _showActions(BuildContext context, WidgetRef ref, Plant p) {
  final s = VTTheme.of(context);
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: s.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: s.glassStroke),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit_outlined, color: s.verdant),
              title: Text('Edit details', style: TextStyle(color: s.textPrimary)),
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => EditPlantSheet(plant: p),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: VTColors.fruiting),
              title: const Text('Remove plant', style: TextStyle(color: VTColors.fruiting)),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(context, ref, p);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
