import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About VerdiTech'),
      ),
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
              'VerdiTech uses a Cellular Automata (CA) model to predict plant growth.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'What is Cellular Automata?'),
            const SizedBox(height: 8),
            const Text(
              'Cellular Automata is a computational model consisting of a grid of cells. Each cell has a state that changes over time based on specific rules. In VerdiTech, we use a 1D timeline CA where each cell represents a day, and the state represents the plant\'s growth stage.',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Environmental Factors'),
            const SizedBox(height: 8),
            const Text(
              'The algorithm takes into account three main environmental factors to calculate a health score:\n\n'
              '• Sunlight\n'
              '• Water\n'
              '• Soil Quality\n\n'
              'This score determines whether the plant will progress normally, experience delayed growth, or regress.',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Philippine Context'),
            const SizedBox(height: 8),
            const Text(
              'The model also applies modifiers based on the Philippine seasons (Tag-init, Tag-ulan, Malamig) to provide context-aware predictions for local crops like Tomato, Eggplant, and Siling Labuyo.',
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                'v1.0.0-mockup',
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
