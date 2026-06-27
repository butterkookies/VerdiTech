import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlantDetailsScreen extends StatelessWidget {
  final String id;
  const PlantDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // Mock plant data based on ID
    final isTomato = id == '1';
    final plantName = isTomato ? 'Tomato (Roma)' : 'Eggplant';
    final stage = isTomato ? 'Flowering' : 'Young Plant';
    final health = isTomato ? 'Good' : 'Excellent';
    final healthColor = isTomato ? Colors.lightGreen : Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: Text(plantName),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            tooltip: 'CA Visualization',
            onPressed: () => context.go('/plant/$id/visualization'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Card(
              color: healthColor.withOpacity(0.1),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: healthColor.withOpacity(0.5)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Icon(Icons.health_and_safety, size: 48, color: healthColor),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Overall Health'),
                        Text(
                          health,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: healthColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Prediction Timeline
            Text(
              'Predicted Growth Timeline',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTimelineItem(context, 'Seedling', 'Completed', Icons.check_circle, Colors.green),
            _buildTimelineItem(context, 'Young Plant', 'Completed', Icons.check_circle, Colors.green),
            _buildTimelineItem(context, 'Flowering', 'Current Stage (Day 14 of ~21)', Icons.adjust, Colors.blue),
            _buildTimelineItem(context, 'Fruiting', 'Estimated in 7 days', Icons.radio_button_unchecked, Colors.grey),
            
            const SizedBox(height: 32),
            
            // Recommendations
            Text(
              'Recommendations',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildRecommendationCard(
              context,
              'Watering',
              'Increase watering frequency. The current Tag-init season requires more moisture for tomatoes in the flowering stage.',
              Icons.water_drop,
            ),
            const SizedBox(height: 8),
            _buildRecommendationCard(
              context,
              'Sunlight',
              'Sunlight is optimal. Maintain current location.',
              Icons.wb_sunny,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(BuildContext context, String title, String subtitle, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 4),
              Container(width: 2, height: 30, color: Colors.grey.shade300),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(BuildContext context, String title, String body, IconData icon) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(body),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
