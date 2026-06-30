import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/plant.dart';
import '../../../providers/database_provider.dart';
import '../../../presentation/theme/verditech_theme.dart';
import '../../../presentation/theme/vt_haptics.dart';

/// Compact single-step editor for renaming a plant and updating its species.
class EditPlantSheet extends ConsumerStatefulWidget {
  final Plant plant;
  const EditPlantSheet({super.key, required this.plant});

  @override
  ConsumerState<EditPlantSheet> createState() => _EditPlantSheetState();
}

class _EditPlantSheetState extends ConsumerState<EditPlantSheet> {
  late final TextEditingController _name =
      TextEditingController(text: widget.plant.name);

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _save() async {
    final newName = _name.text.trim().isEmpty ? widget.plant.name : _name.text.trim();
    if (newName != widget.plant.name) {
      final updated = widget.plant.copyWith(name: newName);
      await ref.read(plantRepositoryProvider).updatePlant(updated);
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: s.surface,
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border.all(color: s.glassStroke),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 5,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: s.textMuted.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            Text(
              'Edit plant',
              style: TextStyle(
                color: s.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: VTSpace.lg),
            _field(s, _name, 'Name'),
            const SizedBox(height: VTSpace.lg),
            Row(
              children: [
                const Spacer(),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: s.verdantDeep,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 14),
                  ),
                  onPressed: () {
                    VTHaptics.confirm();
                    _save();
                  },
                  child: const Text(
                    'Save changes',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  Widget _field(VTScheme s, TextEditingController c, String label) {
    return TextField(
      controller: c,
      style: TextStyle(color: s.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: s.textMuted),
        filled: true,
        fillColor: s.surfaceHigh,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
