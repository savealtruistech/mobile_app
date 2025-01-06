import 'package:flutter/material.dart';
import 'submission_screen.dart';

class DataVisualizationSetupScreen extends StatefulWidget {
  const DataVisualizationSetupScreen({super.key});

  @override
  DataVisualizationSetupScreenState createState() => DataVisualizationSetupScreenState();
}

class DataVisualizationSetupScreenState extends State<DataVisualizationSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedDataView;
  String? selectedVisualization;
  String? selectedNotification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Visualization Setup'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: index < 3 ? Colors.blue : Colors.grey[300],
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Data Visualization Setup',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Fill in the data for your profile. It will take a couple of minutes.',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                buildRadioGroup(
                  title: 'Data View Options',
                  options: [
                    'Real-Time Data',
                    'Historical Data (Last 2, 7, 30 days)',
                    'Analyzed Reports (Premium subscription)',
                  ],
                  selectedValue: selectedDataView,
                  onChanged: (value) {
                    setState(() {
                      selectedDataView = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a data view option';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                buildRadioGroup(
                  title: 'Visualization Preference',
                  options: ['Tables', 'Charts', 'Graphs'],
                  selectedValue: selectedVisualization,
                  onChanged: (value) {
                    setState(() {
                      selectedVisualization = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a visualization preference';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                buildRadioGroup(
                  title: 'Notification Preference',
                  options: ['Email', 'Push Notification'],
                  selectedValue: selectedNotification,
                  onChanged: (value) {
                    setState(() {
                      selectedNotification = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a notification preference';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const SubmissionScreen()),
                      );
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50), // Full-width button
                  ),
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRadioGroup({
    required String title,
    required List<String> options,
    required String? selectedValue,
    required ValueChanged<String?> onChanged,
    required FormFieldValidator<String?> validator,
  }) {
    return FormField<String>(
      validator: validator,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...options.map(
                  (option) => RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: selectedValue,
                onChanged: (value) {
                  onChanged(value);
                  state.didChange(value);
                },
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
