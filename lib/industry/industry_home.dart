import 'package:flutter/material.dart';
import 'user_details.dart';

class ManufacturingScreen extends StatelessWidget {
  const ManufacturingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Details to provide',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'You will need the following information to complete this section.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildInfoOption('Business Information', 'Provide your business information'),
            _buildInfoOption('Address Details', 'Provide your address information'),
            _buildInfoOption('Upload Document & Device Setup', 'Provide us with any valid document'),
            _buildInfoOption('Preferences', 'Notification Preferences (Email, SMS, Push Notifications), Data Visualization Preferences (Graphs, Tables, Charts), and Reporting Frequency (Daily, Weekly, Monthly).'),
            const SizedBox(height: 24),
            const Text(
              textAlign: TextAlign.center,
              'By clicking on Proceed, you consent to providing us with the requested data.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const UserDetailsScreen()),
                  );

                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                    'Proceed',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoOption(String title, String description) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        leading: const Icon(Icons.info, color: Colors.blueAccent),
        title: Text(
            title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        subtitle: Text(description),
      ),
    );
  }
}
