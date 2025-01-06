import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  _UserDetailsScreen createState() => _UserDetailsScreen();
}

class _UserDetailsScreen extends State<UserDetailsScreen> {
  String? studentStatus;
  String? country;
  String? city;
  String climateUnderstanding = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController stateController = TextEditingController();

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
            // Step indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStepIndicator(isActive: true),
                _buildStepIndicator(isActive: true),
                _buildStepIndicator(isActive: false),
                _buildStepIndicator(isActive: false),
              ],
            ),
            const SizedBox(height: 24),
            // Title
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
            // Name input
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Enter Your Name',
                hintText: 'Enter Full Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),
            // Student status
            const Text('Are You a Student?', style: TextStyle(fontSize: 16)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Yes'),
                    value: 'Yes',
                    groupValue: studentStatus,
                    onChanged: (value) {
                      setState(() {
                        studentStatus = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('No'),
                    value: 'No',
                    groupValue: studentStatus,
                    onChanged: (value) {
                      setState(() {
                        studentStatus = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Country dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Country of Residence',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              items: ['Country 1', 'Country 2', 'Country 3'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  country = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            // City dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              items: ['City 1', 'City 2', 'City 3'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  city = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            // State input
            TextField(
              controller: stateController,
              decoration: InputDecoration(
                labelText: 'State/Province',
                hintText: 'Enter State/Province',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),
            // Climate understanding level checkboxes
            const Text('Understanding of Climate Change', style: TextStyle(fontSize: 16)),
            CheckboxListTile(
              title: const Text("Beginner"),
              value: climateUnderstanding == 'Beginner',
              onChanged: (bool? value) {
                setState(() {
                  climateUnderstanding = value! ? 'Beginner' : '';
                });
              },
            ),
            CheckboxListTile(
              title: const Text("Intermediate"),
              value: climateUnderstanding == 'Intermediate',
              onChanged: (bool? value) {
                setState(() {
                  climateUnderstanding = value! ? 'Intermediate' : '';
                });
              },
            ),
            CheckboxListTile(
              title: const Text("Professional"),
              value: climateUnderstanding == 'Professional',
              onChanged: (bool? value) {
                setState(() {
                  climateUnderstanding = value! ? 'Professional' : '';
                });
              },
            ),
            const Spacer(),
            // Next button
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
                  // Navigation
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
