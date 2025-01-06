import 'package:flutter/material.dart';
import 'onboarding.dart';

class CitizenScreen extends StatelessWidget {
  const CitizenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Details to provide',
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The following are information we want from you.',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            const SizedBox(height: 24),
            _buildOptionCard(
              context,
              title: 'Profile Information',
              subtitle: 'Provide your profile information',
              icon: Icons.account_circle,
            ),
            _buildOptionCard(
              context,
              title: 'Employment Status',
              subtitle: 'Select whether you\'re an employee or student',
              icon: Icons.work,
            ),
            _buildOptionCard(
              context,
              title: 'Address Details',
              subtitle: 'Provide your address information',
              icon: Icons.location_on,
            ),
            _buildOptionCard(
              context,
              title: 'Understanding of Climate Change',
              subtitle: 'Choose your level of understanding of climate change: Beginner, Intermediate, or Professional.',
              icon: Icons.eco,
            ),
            const Spacer(),
            const Text(
              'By clicking on Accept and Proceed, you consent to provide us with the requested data.',
              style: TextStyle(color: Colors.black54, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OnboardingScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Accept and Proceed',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context, {required String title, required String subtitle, required IconData icon}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}
