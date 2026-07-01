import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/enums.dart';
import '../../../domain/models/plant.dart';
import '../../../domain/models/environment_profile.dart';
import '../../../domain/engine/ca_engine.dart';
import '../../../providers/database_provider.dart';
import '../../../presentation/theme/verditech_theme.dart';
import '../../../presentation/theme/vt_haptics.dart';
import '../../../presentation/widgets/glass_container.dart';
import '../../../presentation/widgets/stage_chip.dart';
import '../../../services/notification_service.dart';

class AddPlantSheet extends ConsumerStatefulWidget {
  const AddPlantSheet({super.key});

  @override
  ConsumerState<AddPlantSheet> createState() => _AddPlantSheetState();
}

class _AddPlantSheetState extends ConsumerState<AddPlantSheet> {
  final _pageCtrl = PageController();
  final _nameCtrl = TextEditingController();
  int _step = 0;

  PlantType? _species;
  String _location = 'Indoor';
  double _moisture = 0.6;
  double _light = 0.7;
  GrowthStage _stage = GrowthStage.seedling;

  int get _calculatedForecastDays {
    if (_species == null) return 0;
    
    final engine = const CaEngine();
    final dummyPlant = Plant(
      name: 'Temp',
      type: _species!,
      currentStage: _stage,
      plantingDate: DateTime.now(),
      sunlightScore: (_light * 4 + 1).roundToDouble(), // 1 to 5 scale
      waterScore: (_moisture * 4 + 1).roundToDouble(), // 1 to 5 scale
      soilScore: 3,
      season: Season.tagInit,
    );
    final env = EnvironmentProfile(
      sunlight: _light * 4 + 1,
      water: _moisture * 4 + 1,
      soil: 3.0,
      season: Season.tagInit,
    );
    
    return engine.estimateDaysToHarvest(plant: dummyPlant, environment: env);
  }

  // We map PlantType to display icons and an initial "GrowthStage" to show on the card
  IconData _iconForType(PlantType t) {
    switch (t) {
      case PlantType.tomato: return Icons.local_florist;
      case PlantType.eggplant: return Icons.eco;
      case PlantType.silingLabuyo: return Icons.restaurant;
    }
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  bool get _canAdvance {
    if (_step == 0) return _species != null;
    if (_step == 1) return _nameCtrl.text.trim().isNotEmpty;
    return true;
  }

  void _next() async {
    if (_step < 2) {
      setState(() => _step++);
      _pageCtrl.animateToPage(
        _step,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOut,
      );
    } else {
      VTHaptics.confirm();
      final name = _nameCtrl.text.trim();
      final newPlant = Plant(
        name: name.isEmpty ? _species!.displayName : name,
        type: _species!,
        plantingDate: DateTime.now(),
        currentStage: _stage,
        sunlightScore: (_light * 5).clamp(1, 5).roundToDouble(),
        waterScore: (_moisture * 5).clamp(1, 5).roundToDouble(),
        soilScore: 3.0,
        season: Season.fromDate(DateTime.now()),
      );
      
      // Save directly using repository
      final savedPlant = await ref.read(plantRepositoryProvider).addPlant(newPlant);
      
      // Schedule notifications for the new plant
      await NotificationService.scheduleForPlant(savedPlant);
      
      if (mounted) Navigator.of(context).pop(true);
    }
  }

  void _back() {
    if (_step == 0) {
      Navigator.of(context).pop();
      return;
    }
    setState(() => _step--);
    _pageCtrl.animateToPage(
      _step,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOut,
    );
  }

  void _showInfo(String title, String body) {
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

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.82,
        decoration: BoxDecoration(
          color: s.surface,
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border.all(color: s.glassStroke),
        ),
        child: Column(
          children: [
            // Grab handle.
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: s.textMuted.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            // Header.
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    switch (_step) {
                      0 => 'Choose a species',
                      1 => 'Name & environment',
                      _ => 'Confirm forecast',
                    },
                    style: TextStyle(
                      color: s.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: VTSpace.md),
                  _StepBar(step: _step, total: 3),
                ],
              ),
            ),
            // Pages.
            Expanded(
              child: PageView(
                controller: _pageCtrl,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildSpeciesStep(s),
                  _buildDetailsStep(s),
                  _buildConfirmStep(s),
                ],
              ),
            ),
            // Footer.
            Padding(
              padding: EdgeInsets.fromLTRB(
                  20,
                  12,
                  20,
                  16 + MediaQuery.of(context).padding.bottom),
              child: Row(
                children: [
                  TextButton(
                    onPressed: _back,
                    child: Text(
                      _step == 0 ? 'Cancel' : 'Back',
                      style: TextStyle(color: s.textMuted),
                    ),
                  ),
                  const Spacer(),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor:
                          _canAdvance ? s.verdantDeep : s.surfaceHigh,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14),
                    ),
                    onPressed: _canAdvance ? _next : null,
                    child: Text(
                      _step == 2 ? 'Start tracking' : 'Continue',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeciesStep(VTScheme s) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: VTSpace.md,
        crossAxisSpacing: VTSpace.md,
        childAspectRatio: 1.4,
      ),
      itemCount: PlantType.values.length,
      itemBuilder: (_, i) {
        final opt = PlantType.values[i];
        final selected = _species == opt;
        return GestureDetector(
          onTap: () {
            VTHaptics.select();
            setState(() => _species = opt);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: const EdgeInsets.all(VTSpace.md),
            decoration: BoxDecoration(
              color: s.surfaceHigh,
              borderRadius: BorderRadius.circular(VTSpace.radius),
              border: Border.all(
                color: selected ? VTColors.flowering : s.glassStroke,
                width: selected ? 2 : 1,
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                          color: VTColors.flowering.withValues(alpha: 0.25),
                          blurRadius: 20)
                    ]
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: VTGradients.forStage(GrowthStage.flowering),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                      Icon(_iconForType(opt), color: Colors.black87, size: 20),
                ),
                Text(opt.displayName,
                    style: TextStyle(
                        color: s.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailsStep(VTScheme s) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      children: [
        TextField(
          controller: _nameCtrl,
          onChanged: (_) => setState(() {}),
          style: TextStyle(color: s.textPrimary),
          decoration: InputDecoration(
            hintText: 'Give your plant a name',
            hintStyle: TextStyle(color: s.textMuted),
            filled: true,
            fillColor: s.surfaceHigh,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: VTSpace.lg),
        Text('Location',
            style: TextStyle(
                color: s.textPrimary, fontWeight: FontWeight.w700)),
        const SizedBox(height: VTSpace.sm),
        Wrap(
          spacing: VTSpace.sm,
          children: ['Indoor', 'Outdoor', 'Greenhouse'].map((loc) {
            final sel = _location == loc;
            return ChoiceChip(
              label: Text(loc),
              selected: sel,
              onSelected: (_) {
                VTHaptics.select();
                setState(() => _location = loc);
              },
              selectedColor: s.verdantDeep,
              backgroundColor: s.surfaceHigh,
              labelStyle: TextStyle(
                  color: sel ? Colors.white : s.textMuted,
                  fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
            );
          }).toList(),
        ),
        const SizedBox(height: VTSpace.lg),
        _EnvSlider(
          label: 'Starting moisture',
          icon: Icons.water_drop_outlined,
          color: VTColors.seedling,
          value: _moisture,
          description: _moisture < 0.35 ? 'Dry: Finger comes out clean' : _moisture > 0.70 ? 'Wet: Finger is muddy' : 'Moist: Soil clings slightly to finger',
          onInfoTap: () => _showInfo(
            'How to measure moisture',
            'Use the "Finger Test": Stick your index finger about 2 inches into the soil.\n\n• Dry (0-30%): Finger comes out clean.\n• Moist (35-70%): Soil clings slightly. Perfect starting point.\n• Wet (75-100%): Finger is muddy.',
          ),
          onChanged: (v) => setState(() => _moisture = v),
        ),
        _EnvSlider(
          label: 'Light exposure',
          icon: Icons.wb_sunny_outlined,
          color: VTColors.harvest,
          value: _light,
          description: _light < 0.35 ? 'Low light: Barely any shadow cast' : _light > 0.70 ? 'High light: Sharp, distinct shadow' : 'Medium light: Soft, fuzzy shadow',
          onInfoTap: () => _showInfo(
            'How to measure light',
            'Use the "Shadow Test": Hold your hand about 12 inches above the plant during midday.\n\n• Low Light (0-30%): Barely any shadow.\n• Medium Light (35-70%): Soft and fuzzy shadow.\n• High Light (75-100%): Sharp, distinct shadow.',
          ),
          onChanged: (v) => setState(() => _light = v),
        ),
        const SizedBox(height: VTSpace.lg),
        Text(
          'Current growth stage',
          style: TextStyle(color: s.textPrimary, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: VTSpace.sm),
        Wrap(
          spacing: VTSpace.sm,
          runSpacing: VTSpace.sm,
          children: GrowthStage.values.map((stage) {
            final sel = _stage == stage;
            return ChoiceChip(
              label: Text(stage.displayName),
              selected: sel,
              onSelected: (_) {
                VTHaptics.select();
                setState(() => _stage = stage);
              },
              selectedColor: stage.color,
              backgroundColor: s.surfaceHigh,
              labelStyle: TextStyle(
                color: sel ? Colors.white : s.textMuted,
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildConfirmStep(VTScheme s) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      children: [
        GlassContainer(
          tint: s.surfaceHigh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  StageChip(stage: _stage, compact: true),
                  const Spacer(),
                  Text('Day 1',
                      style: TextStyle(color: s.textMuted, fontSize: 12)),
                ],
              ),
              const SizedBox(height: VTSpace.md),
              Text(
                _nameCtrl.text.trim().isEmpty
                    ? 'Unnamed plant'
                    : _nameCtrl.text.trim(),
                style: TextStyle(
                    color: s.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              Text('${_species?.displayName ?? '—'} · $_location',
                  style: TextStyle(color: s.textMuted, fontSize: 13)),
              const Divider(height: 32),
              _confirmRow(s, Icons.water_drop_outlined, 'Moisture',
                  '${(_moisture * 100).round()}%'),
              _confirmRow(s, Icons.wb_sunny_outlined, 'Light',
                  '${(_light * 100).round()}%'),
              const SizedBox(height: VTSpace.md),
              Container(
                padding: const EdgeInsets.all(VTSpace.md),
                decoration: BoxDecoration(
                  color: s.verdant.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(Icons.insights_rounded, color: s.verdantDeep),
                    const SizedBox(width: VTSpace.sm),
                    Expanded(
                      child: Text(
                        'CA engine forecasts harvest in ~$_calculatedForecastDays days under these conditions.',
                        style: TextStyle(
                            color: s.textPrimary, fontSize: 12, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _confirmRow(
      VTScheme s, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: s.textMuted),
          const SizedBox(width: VTSpace.sm),
          Text(label, style: TextStyle(color: s.textMuted, fontSize: 13)),
          const Spacer(),
          Text(value,
              style: TextStyle(
                  color: s.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _StepBar extends StatelessWidget {
  final int step, total;
  const _StepBar({required this.step, required this.total});

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return Row(
      children: List.generate(total, (i) {
        final active = i <= step;
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 5,
            margin: EdgeInsets.only(right: i == total - 1 ? 0 : 6),
            decoration: BoxDecoration(
              gradient: active ? VTGradients.verdant : null,
              color: active ? null : s.surfaceHigh,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        );
      }),
    );
  }
}

class _EnvSlider extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final double value;
  final String description;
  final VoidCallback onInfoTap;
  final ValueChanged<double> onChanged;

  const _EnvSlider({
    required this.label,
    required this.icon,
    required this.color,
    required this.value,
    required this.description,
    required this.onInfoTap,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
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
              Text('${(value * 100).round()}%',
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
            child: Slider(value: value, onChanged: onChanged),
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
}
