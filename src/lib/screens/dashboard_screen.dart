import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock list of plants
    final List<Map<String, String>> plants = [
      {'id': '1', 'name': 'Tomato (Roma)', 'stage': 'Flowering', 'health': 'Good'},
      {'id': '2', 'name': 'Eggplant', 'stage': 'Young Plant', 'health': 'Excellent'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('VerdiTech Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => context.go('/about'),
            tooltip: 'About VerdiTech',
          ),
        ],
      ),
      body: plants.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_florist, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text('No plants tracked yet.', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  const Text('Tap the + button to add a plant.'),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: plants.length,
              itemBuilder: (context, index) {
                final plant = plants[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      child: Icon(Icons.eco, color: Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                    title: Text(plant['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.timeline, size: 16),
                          const SizedBox(width: 4),
                          Text(plant['stage']!),
                          const SizedBox(width: 16),
                          const Icon(Icons.health_and_safety, size: 16),
                          const SizedBox(width: 4),
                          Text(plant['health']!),
                        ],
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      context.go('/plant/${plant['id']}');
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/add-plant'),
        icon: const Icon(Icons.add),
        label: const Text('Add Plant'),
      ),
    );
  }
}
