import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  String _selectedPlant = 'Tomato';
  String _selectedStage = 'Seedling';
  String _selectedSeason = 'Tag-init';
  
  double _sunlightScore = 3;
  double _waterScore = 3;
  double _soilScore = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Plant'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Plant Information'),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedPlant,
              decoration: const InputDecoration(
                labelText: 'Plant Type',
                border: OutlineInputBorder(),
              ),
              items: ['Tomato', 'Eggplant', 'Siling Labuyo']
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedPlant = val!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedStage,
              decoration: const InputDecoration(
                labelText: 'Current Growth Stage',
                border: OutlineInputBorder(),
              ),
              items: ['Seedling', 'Young Plant', 'Flowering', 'Fruiting']
                  .map((stage) => DropdownMenuItem(value: stage, child: Text(stage)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedStage = val!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedSeason,
              decoration: const InputDecoration(
                labelText: 'Season',
                border: OutlineInputBorder(),
              ),
              items: ['Tag-init', 'Tag-ulan', 'Malamig']
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedSeason = val!),
            ),
            const SizedBox(height: 32),
            _buildSectionHeader('Environmental Factors (1 - 5)'),
            const SizedBox(height: 8),
            _buildSlider('Sunlight', _sunlightScore, (val) => setState(() => _sunlightScore = val)),
            _buildSlider('Water', _waterScore, (val) => setState(() => _waterScore = val)),
            _buildSlider('Soil Quality', _soilScore, (val) => setState(() => _soilScore = val)),
            
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: () {
                  // Mock save
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Plant saved successfully!')),
                  );
                  context.go('/');
                },
                child: const Text('Save & Predict Growth'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }

  Widget _buildSlider(String label, double value, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text('${value.toInt()}', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
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
