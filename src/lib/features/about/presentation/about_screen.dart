import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About VerdiTech')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How It Works',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'VerdiTech uses a Cellular Automata (CA) model to predict plant '
              'growth and generate personalised care recommendations.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'What is Cellular Automata?'),
            const SizedBox(height: 8),
            const Text(
              'Cellular Automata is a computational model consisting of a grid of '
              'cells, each with a state that evolves over time based on specific '
              'rules. In VerdiTech, we use a 1D CA where each "cell" represents a '
              'single day. The cell\'s state is the plant\'s growth stage '
              '(Seedling → Young Plant → Flowering → Fruiting → Harvest Ready).',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Environmental Factors'),
            const SizedBox(height: 8),
            const Text(
              'The algorithm weights three daily factors to compute a Health Score '
              'from 0–100%:\n\n'
              '• Sunlight — how much direct sunlight the plant receives\n'
              '• Water — availability and consistency of irrigation\n'
              '• Soil Quality — fertility, drainage, and pH suitability\n\n'
              'Each plant type (Tomato, Eggplant, Siling Labuyo) has different '
              'factor weights based on its agricultural profile.',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Transition Rules'),
            const SizedBox(height: 8),
            const Text(
              '• Score ≥ 70% + minimum stage days met → stage progresses\n'
              '• 40–69% → progression delayed (×1.5 time)\n'
              '• < 40% → risk of regression to the previous stage',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Philippine Seasonal Modifiers'),
            const SizedBox(height: 8),
            const Text(
              'The model also applies seasonal modifiers based on the Philippine '
              'seasons (Tag-init, Tag-ulan, Malamig) to provide context-aware '
              'predictions for local crops. For example, Tomatoes perform best '
              'during Malamig (Cool Season) and are most stressed during Tag-ulan.',
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                'VerdiTech v1.0 — Capstone Project',
                style: TextStyle(color: Colors.grey.shade500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
