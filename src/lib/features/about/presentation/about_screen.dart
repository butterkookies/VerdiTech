import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../presentation/theme/verditech_theme.dart';
import '../../../presentation/widgets/glass_container.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);

    return Scaffold(
      backgroundColor: s.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: s.textPrimary),
        title: Text(
          'About VerdiTech',
          style: TextStyle(
            color: s.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Hero banner ─────────────────────────────────────────────────
            Container(
              height: 180,
              decoration: BoxDecoration(
                gradient: VTGradients.heroFor(s.brightness),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: s.verdant.withOpacity(0.25),
                    blurRadius: 40,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.eco_rounded,
                    size: 90,
                    color: s.verdantDeep.withOpacity(0.18),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'VerdiTech',
                        style: TextStyle(
                          color: s.textPrimary,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1.5,
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 600.ms)
                          .slideY(begin: 0.3, end: 0),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: s.verdant.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'v1.0  |  Capstone Project',
                          style: TextStyle(
                            color: s.textMuted,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 250.ms)
                          .slideY(begin: 0.3, end: 0),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: VTSpace.xl),

            // ── How it works ────────────────────────────────────────────────
            _SectionHeader(title: 'How It Works', scheme: s)
                .animate()
                .fadeIn(delay: 350.ms),
            const SizedBox(height: VTSpace.md),
            GlassContainer(
              child: Text(
                'VerdiTech uses a Cellular Automata (CA) model to predict plant '
                'growth and generate personalised care recommendations.',
                style:
                    TextStyle(color: s.textPrimary, fontSize: 14, height: 1.6),
              ),
            ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.08, end: 0),
            const SizedBox(height: VTSpace.xl),

            // ── What is CA? ─────────────────────────────────────────────────
            _SectionHeader(title: 'What is Cellular Automata?', scheme: s)
                .animate()
                .fadeIn(delay: 450.ms),
            const SizedBox(height: VTSpace.md),
            GlassContainer(
              child: Text(
                'Cellular Automata is a computational model consisting of a grid of '
                'cells, each with a state that evolves over time based on specific '
                'rules. In VerdiTech, we use a 1D CA where each "cell" represents a '
                'single day. The cell\'s state is the plant\'s growth stage '
                '(Seedling → Young Plant → Flowering → Fruiting → Harvest Ready).',
                style:
                    TextStyle(color: s.textPrimary, fontSize: 14, height: 1.6),
              ),
            ).animate().fadeIn(delay: 500.ms).slideX(begin: 0.08, end: 0),
            const SizedBox(height: VTSpace.xl),

            // ── Environmental factors ───────────────────────────────────────
            _SectionHeader(title: 'Environmental Factors', scheme: s)
                .animate()
                .fadeIn(delay: 550.ms),
            const SizedBox(height: VTSpace.md),
            _FactorCard(
              icon: Icons.wb_sunny_rounded,
              color: VTColors.harvest,
              title: 'Sunlight',
              desc: 'How much direct sunlight the plant receives each day.',
              delay: 600,
            ),
            _FactorCard(
              icon: Icons.water_drop_rounded,
              color: VTColors.seedling,
              title: 'Water',
              desc: 'Availability and consistency of irrigation.',
              delay: 650,
            ),
            _FactorCard(
              icon: Icons.grass_rounded,
              color: VTColors.fruiting,
              title: 'Soil Quality',
              desc: 'Fertility, drainage, and pH suitability.',
              delay: 700,
            ),
            GlassContainer(
              child: Text(
                'Each plant type (Tomato, Eggplant, Siling Labuyo) has different '
                'factor weights based on its agricultural profile. The three factors '
                'are combined into a Health Score from 0–100%.',
                style:
                    TextStyle(color: s.textPrimary, fontSize: 14, height: 1.6),
              ),
            ).animate().fadeIn(delay: 720.ms).slideX(begin: 0.08, end: 0),
            const SizedBox(height: VTSpace.xl),

            // ── Transition rules ────────────────────────────────────────────
            _SectionHeader(title: 'Transition Rules', scheme: s)
                .animate()
                .fadeIn(delay: 750.ms),
            const SizedBox(height: VTSpace.md),
            _RuleCard(
              color: VTColors.young,
              label: 'Score >= 70% + minimum stage days met',
              outcome: 'Stage advances',
              delay: 800,
            ),
            _RuleCard(
              color: VTColors.harvest,
              label: 'Score between 40–69%',
              outcome: 'Progression delayed (x1.5 time)',
              delay: 840,
            ),
            _RuleCard(
              color: VTColors.fruiting,
              label: 'Score below 40%',
              outcome: 'Risk of regression to previous stage',
              delay: 880,
            ),
            const SizedBox(height: VTSpace.xl),

            // ── Philippine Seasonal Modifiers ────────────────────────────────
            _SectionHeader(
                    title: 'Philippine Seasonal Modifiers', scheme: s)
                .animate()
                .fadeIn(delay: 920.ms),
            const SizedBox(height: VTSpace.md),
            GlassContainer(
              child: Text(
                'The model applies seasonal modifiers based on Philippine seasons '
                '(Tag-init, Tag-ulan, Malamig) to provide context-aware predictions '
                'for local crops. For example, Tomatoes perform best during Malamig '
                '(Cool Season) and are most stressed during Tag-ulan.',
                style:
                    TextStyle(color: s.textPrimary, fontSize: 14, height: 1.6),
              ),
            ).animate().fadeIn(delay: 960.ms).slideX(begin: 0.08, end: 0),
            const SizedBox(height: VTSpace.xxl),
            Center(
              child: Text(
                'Made with care by the VerdiTech Team',
                style: TextStyle(color: s.textMuted, fontSize: 13),
              ),
            ).animate().fadeIn(delay: 1000.ms),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-widgets
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final String title;
  final VTScheme scheme;
  const _SectionHeader({required this.title, required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: scheme.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _FactorCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title, desc;
  final int delay;
  const _FactorCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.desc,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: VTSpace.md),
      child: GlassContainer(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: VTSpace.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: s.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(desc,
                      style: TextStyle(
                          color: s.textMuted, fontSize: 12, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.08, end: 0),
    );
  }
}

class _RuleCard extends StatelessWidget {
  final Color color;
  final String label, outcome;
  final int delay;
  const _RuleCard({
    required this.color,
    required this.label,
    required this.outcome,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: VTSpace.sm),
      child: GlassContainer(
        child: Row(
          children: [
            Container(
              width: 4,
              height: 44,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: VTSpace.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          color: s.textMuted, fontSize: 12, height: 1.3)),
                  const SizedBox(height: 2),
                  Text(outcome,
                      style: TextStyle(
                          color: s.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.08, end: 0),
    );
  }
}
