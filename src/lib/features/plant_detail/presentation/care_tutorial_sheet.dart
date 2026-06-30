import 'package:flutter/material.dart';

import '../../../presentation/theme/verditech_theme.dart';
import '../../../presentation/widgets/glass_container.dart';

class CareTutorialSheet extends StatelessWidget {
  final String species;
  const CareTutorialSheet({super.key, required this.species});

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    final guide = _guides[species] ?? _guides['Tomato']!;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: s.bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border.all(color: s.glassStroke),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: s.textMuted.withOpacity(0.4),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: s.verdant.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.menu_book_rounded,
                      color: s.verdantDeep, size: 22),
                ),
                const SizedBox(width: VTSpace.md),
                Text(
                  '$species Care Guide',
                  style: TextStyle(
                    color: s.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: VTSpace.lg),
          // Sections
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              children: [
                _Section(
                  icon: Icons.water_drop_rounded,
                  color: VTColors.seedling,
                  title: 'Watering',
                  content: guide.watering,
                ),
                _Section(
                  icon: Icons.wb_sunny_rounded,
                  color: VTColors.harvest,
                  title: 'Light and Environment',
                  content: guide.light,
                ),
                _Section(
                  icon: Icons.content_cut_rounded,
                  color: VTColors.young,
                  title: 'Pruning and Maintenance',
                  content: guide.pruning,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section card
// ---------------------------------------------------------------------------

class _Section extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title, content;

  const _Section({
    required this.icon,
    required this.color,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: VTSpace.md),
      child: GlassContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                const SizedBox(width: VTSpace.md),
                Text(
                  title,
                  style: TextStyle(
                    color: s.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: VTSpace.md),
            Text(
              content,
              style: TextStyle(
                color: s.textMuted,
                fontSize: 13,
                height: 1.55,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Care guide data
// ---------------------------------------------------------------------------

class _CareGuide {
  final String watering, light, pruning;
  const _CareGuide(
      {required this.watering, required this.light, required this.pruning});
}

const _guides = <String, _CareGuide>{
  'Tomato': _CareGuide(
    watering:
        'Water deeply and regularly, aiming for 1 to 2 inches per week. '
        'Avoid overhead watering to prevent blight. Water at the base of the plant early in the morning.',
    light:
        'Requires 6 to 8 hours of direct, full sun daily for best fruit production. '
        'South-facing placement is ideal for indoor growing.',
    pruning:
        'Pinch off suckers — the small shoots that appear between the main stem '
        'and branches — to direct energy into fruit production.',
  ),
  'Eggplant': _CareGuide(
    watering:
        'Water consistently, aiming for about 1 inch per week. Eggplants are '
        'sensitive to drought and waterlogging equally, so keep soil evenly moist.',
    light:
        'Needs a minimum of 6 hours of full sun per day. Eggplants are warm-season '
        'crops and thrive in temperatures between 21 and 30 degrees Celsius.',
    pruning:
        'Remove any damaged or diseased leaves promptly. After fruiting begins, '
        'you can remove some lower leaves to improve air circulation.',
  ),
  'Siling Labuyo': _CareGuide(
    watering:
        'Allow the top inch of soil to dry out between waterings. '
        'Siling Labuyo is drought-tolerant but prolonged water stress will reduce heat and yield.',
    light:
        'Absolutely needs full sun — at least 6 to 8 hours per day — '
        'to produce its characteristic fiery heat.',
    pruning:
        'Minimal pruning required. Pinch off the very first flower buds to encourage '
        'the plant to focus energy on vegetative growth before fruiting.',
  ),
};
