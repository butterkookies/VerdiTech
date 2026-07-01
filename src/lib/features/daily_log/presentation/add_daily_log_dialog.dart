import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/daily_log_providers.dart';
import '../../../presentation/theme/verditech_theme.dart';

class AddDailyLogDialog extends ConsumerWidget {
  final int plantId;
  const AddDailyLogDialog({super.key, required this.plantId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dailyLogFormProvider);
    final notifier = ref.read(dailyLogFormProvider.notifier);
    final s = VTTheme.of(context);

    return AlertDialog(
      backgroundColor: s.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: s.glassStroke),
      ),
      title: Text('Add Daily Log', style: TextStyle(color: s.textPrimary, fontWeight: FontWeight.w800)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSlider(
              context,
              label: 'Sunlight',
              icon: Icons.wb_sunny_outlined,
              color: VTColors.harvest,
              value: state.sunlightScore,
              description: state.sunlightScore < 2.5 ? 'Low light: Barely any shadow cast' : state.sunlightScore > 3.5 ? 'High light: Sharp, distinct shadow' : 'Medium light: Soft, fuzzy shadow',
              onInfoTap: () => _showInfo(context, 'How to measure light', 'Use the "Shadow Test": Hold your hand about 12 inches above the plant during midday.\n\n• Low Light (20-40%): Barely any shadow.\n• Medium Light (60%): Soft and fuzzy shadow.\n• High Light (80-100%): Sharp, distinct shadow.'),
              onChanged: notifier.updateSunlight,
            ),
            _buildSlider(
              context,
              label: 'Water',
              icon: Icons.water_drop_outlined,
              color: VTColors.seedling,
              value: state.waterScore,
              description: state.waterScore < 2.5 ? 'Dry: Finger comes out clean' : state.waterScore > 3.5 ? 'Wet: Finger is muddy' : 'Moist: Soil clings slightly to finger',
              onInfoTap: () => _showInfo(context, 'How to measure moisture', 'Use the "Finger Test": Stick your index finger about 2 inches into the soil.\n\n• Dry (20-40%): Finger comes out clean.\n• Moist (60%): Soil clings slightly.\n• Wet (80-100%): Finger is muddy.'),
              onChanged: notifier.updateWater,
            ),
            _buildSlider(
              context,
              label: 'Soil Quality',
              icon: Icons.grass_outlined,
              color: VTColors.fruiting,
              value: state.soilScore,
              description: state.soilScore < 2.5 ? 'Poor: Compacted or lacking nutrients' : state.soilScore > 3.5 ? 'Excellent: Rich, dark, well-draining' : 'Average: Standard potting mix',
              onInfoTap: () => _showInfo(context, 'How to assess soil', 'Soil quality is hard to measure daily, but watch out for:\n\n• Poor (20-40%): Water pools on top or runs straight through.\n• Average (60%): Holds some moisture but drains well.\n• Excellent (80-100%): Dark, earthy smell, very rich in compost.'),
              onChanged: notifier.updateSoil,
            ),
            const SizedBox(height: 16),
            TextField(
              style: TextStyle(color: s.textPrimary),
              decoration: InputDecoration(
                labelText: 'Notes (optional)',
                labelStyle: TextStyle(color: s.textMuted),
                filled: true,
                fillColor: s.surfaceHigh,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
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
          child: Text('Cancel', style: TextStyle(color: s.textMuted)),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: s.verdantDeep),
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

  Widget _buildSlider(BuildContext context, {
    required String label, 
    required double value, 
    required ValueChanged<double> onChanged,
    required IconData icon,
    required Color color,
    required String description,
    required VoidCallback onInfoTap,
  }) {
    final s = VTTheme.of(context);
    // Convert 1-5 to 0-100% for display
    final percentage = ((value - 1) / 4 * 100).round();
    
    return Padding(
      padding: const EdgeInsets.only(bottom: VTSpace.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: VTSpace.sm),
              Text(label,
                  style: TextStyle(
                      color: s.textPrimary, fontWeight: FontWeight.w600)),
              IconButton(
                padding: const EdgeInsets.only(left: 4),
                constraints: const BoxConstraints(),
                icon: Icon(Icons.info_outline, size: 16, color: s.textMuted),
                onPressed: onInfoTap,
              ),
              const Spacer(),
              Text('$percentage%',
                  style: TextStyle(color: s.textMuted, fontSize: 13)),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: color,
              inactiveTrackColor: s.surfaceHigh,
              thumbColor: color,
              overlayColor: color.withValues(alpha: 0.2),
            ),
            child: Slider(
              value: value, 
              min: 1, 
              max: 5, 
              divisions: 4, 
              onChanged: onChanged
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              description,
              style: TextStyle(color: s.textMuted, fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  void _showInfo(BuildContext context, String title, String body) {
    final s = VTTheme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: s.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: s.glassStroke),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: s.verdantDeep),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(title, style: TextStyle(color: s.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(body, style: TextStyle(color: s.textPrimary, fontSize: 14, height: 1.5)),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: s.verdantDeep),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Got it'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
