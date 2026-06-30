import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/daily_log_providers.dart';

class AddDailyLogDialog extends ConsumerWidget {
  final int plantId;
  const AddDailyLogDialog({super.key, required this.plantId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dailyLogFormProvider);
    final notifier = ref.read(dailyLogFormProvider.notifier);

    return AlertDialog(
      title: const Text('Add Daily Log'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSlider(
              context,
              label: 'Sunlight',
              value: state.sunlightScore,
              onChanged: notifier.updateSunlight,
            ),
            _buildSlider(
              context,
              label: 'Water',
              value: state.waterScore,
              onChanged: notifier.updateWater,
            ),
            _buildSlider(
              context,
              label: 'Soil Quality',
              value: state.soilScore,
              onChanged: notifier.updateSoil,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: notifier.updateNote,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: state.isSaving ? null : () => context.pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: state.isSaving
              ? null
              : () async {
                  await notifier.save(plantId);
                  if (context.mounted) {
                    context.pop();
                  }
                },
          child: state.isSaving
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Save'),
        ),
      ],
    );
  }

  Widget _buildSlider(BuildContext context, {required String label, required double value, required ValueChanged<double> onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text('$label: ${value.toInt()}'),
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
