import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/enums.dart';
import '../../../providers/plant_providers.dart';

class AddPlantScreen extends ConsumerStatefulWidget {
  const AddPlantScreen({super.key});

  @override
  ConsumerState<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends ConsumerState<AddPlantScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(plantFormProvider);
    final notifier = ref.read(plantFormProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Plant')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(context, 'Plant Information'),
              const SizedBox(height: 16),

              // Plant name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Plant Name (optional)',
                  hintText: 'e.g. My Tomato Pot #1',
                  border: OutlineInputBorder(),
                ),
                onChanged: notifier.updateName,
              ),
              const SizedBox(height: 16),

              // Plant type
              DropdownButtonFormField<PlantType>(
                initialValue: formState.type,
                decoration: const InputDecoration(
                  labelText: 'Plant Type',
                  border: OutlineInputBorder(),
                ),
                items: PlantType.values
                    .map((t) => DropdownMenuItem(
                          value: t,
                          child: Text(t.displayName),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) notifier.updateType(val);
                },
              ),
              const SizedBox(height: 16),

              // Growth stage
              DropdownButtonFormField<GrowthStage>(
                initialValue: formState.currentStage,
                decoration: const InputDecoration(
                  labelText: 'Current Growth Stage',
                  border: OutlineInputBorder(),
                ),
                items: GrowthStage.values
                    .where((s) => s != GrowthStage.harvestReady)
                    .map((s) => DropdownMenuItem(
                          value: s,
                          child: Text(s.displayName),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) notifier.updateCurrentStage(val);
                },
              ),
              const SizedBox(height: 16),

              // Season
              DropdownButtonFormField<Season>(
                initialValue: formState.season,
                decoration: const InputDecoration(
                  labelText: 'Season',
                  border: OutlineInputBorder(),
                ),
                items: Season.values
                    .map((s) => DropdownMenuItem(
                          value: s,
                          child: Text(s.displayName),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) notifier.updateSeason(val);
                },
              ),
              const SizedBox(height: 32),

              _buildSectionHeader(context, 'Environmental Factors (1–5)'),
              const SizedBox(height: 8),

              _buildSlider(
                context,
                label: 'Sunlight',
                value: formState.sunlightScore,
                onChanged: notifier.updateSunlight,
              ),
              _buildSlider(
                context,
                label: 'Water',
                value: formState.waterScore,
                onChanged: notifier.updateWater,
              ),
              _buildSlider(
                context,
                label: 'Soil Quality',
                value: formState.soilScore,
                onChanged: notifier.updateSoil,
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: formState.isSaving
                      ? null
                      : () async {
                          await notifier.save();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Plant saved successfully!'),
                              ),
                            );
                            context.go('/');
                          }
                        },
                  child: formState.isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Save & Predict Growth'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }

  Widget _buildSlider(
    BuildContext context, {
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(
                value.toInt().toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Slider(
          value: value,
          min: 1,
          max: 5,
          divisions: 4,
          label: value.toInt().toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
