import 'package:flutter/material.dart';
import 'qr_code.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postalController = TextEditingController();
  final TextEditingController _businessAddressController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text('User Details', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildStepper(),
            const SizedBox(height: 16),
            _buildTextField('Full Name', _fullNameController),
            const SizedBox(height: 16),
            _buildTextField('Email Address', _emailController),
            const SizedBox(height: 16),
            _buildTextField(
                'Name of Consulting Firm/Company', _businessNameController),
            const SizedBox(height: 16),
            _buildTextField('Country', _countryController),
            const SizedBox(height: 16),
            _buildTextField('City', _cityController),
            const SizedBox(height: 16),
            _buildTextField('State/Province', _stateController),
            const SizedBox(height: 16),
            _buildTextField('Zip/Postal Code', _postalController),
            const SizedBox(height: 16),
            _buildTextField('Business Address', _businessAddressController),
            const SizedBox(height: 16),


            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const QrCodeScannerScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.circle, color: Colors.blue, size: 12),
        Container(width: 40, height: 1, color: Colors.blue),
        const Icon(Icons.circle_outlined, color: Colors.grey, size: 12),
        Container(width: 40, height: 1, color: Colors.grey),
        const Icon(Icons.circle_outlined, color: Colors.grey, size: 12),
        Container(width: 40, height: 1, color: Colors.grey),
        const Icon(Icons.circle_outlined, color: Colors.grey, size: 12),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}