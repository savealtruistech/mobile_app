import 'package:flutter/material.dart';
import 'user_details.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildStepIndicator(isActive: true),
                _buildStepIndicator(isActive: false),
                _buildStepIndicator(isActive: false),
                _buildStepIndicator(isActive: false),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Concerned Citizen Onboarding',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Let’s set up your profile to join the fight for a cleaner environment.',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Your Name',
                hintText: 'Enter Full Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Are You a Student?', style: TextStyle(fontSize: 16)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Yes'),
                    value: true,
                    groupValue: true,
                    onChanged: (bool? value) {},
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('No'),
                    value: false,
                    groupValue: false,
                    onChanged: (bool? value) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Country of Residence',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              items: <String>['Country 1', 'Country 2', 'Country 3']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {},
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              items: <String>['City 1', 'City 2', 'City 3']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {},
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'State/Province',
                hintText: 'Enter State/Province',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Understanding of Climate Change', style: TextStyle(fontSize: 16)),
            CheckboxListTile(
              title: const Text("Beginner"),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: const Text("Intermediate"),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: const Text("Professional"),
              value: false,
              onChanged: (bool? value) {},
            ),
            const Spacer(),
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
                      builder: (context) => const UserDetailsScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator({required bool isActive}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CircleAvatar(
        radius: 4,
        backgroundColor: isActive ? Colors.blue : Colors.grey[300],
      ),
    );
  }
}
