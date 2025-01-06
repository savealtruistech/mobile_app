import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'qr_code.dart';
import 'registration_progress_tracker.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  UserDetailsScreenState createState() => UserDetailsScreenState();
}

class UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  String _jobTitle = 'Director';
  String _industryType = 'Technology';
  List<String> roles = ['Director', 'Manager', 'Developer'];
  List<String> industry = ['Technology', 'Finance', 'Education'];
  bool _isBusinessRegistered = true;
  bool _isDevicePurchased = true;
  PlatformFile? _uploadedFile;


  @override
  void dispose() {
    saveLastScreen('UserDetailsScreen');
    super.dispose();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _uploadedFile = result.files.first;
      });
    }
  }

  Future<void> _saveUserDetailsToFirestore({
    required String fullName,
    required String email,
    required String businessName,
    required String jobTitle,
    required String industryType,
    required bool isBusinessRegistered,
    String? uploadedFileName,
    required bool isDevicePurchased,
  }) async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('No user is currently logged in.');
    }

    final String userId = user.uid;

    final CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      await users.doc(userId).set({
        'fullName': fullName,
        'email': email,
        'businessName': businessName,
        'jobTitle': jobTitle,
        'industryType': industryType,
        'isBusinessRegistered': isBusinessRegistered,
        'uploadedFileName': uploadedFileName ?? '',
        'isDevicePurchased': isDevicePurchased,
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to save user details: $e');
    }
  }

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
            _buildTextField('Business Name', _businessNameController),
            const SizedBox(height: 16),
            _buildDropdown('Job Title', _jobTitle, roles),
            const SizedBox(height: 16),
            _buildDropdown('Industry Type', _industryType, industry),
            const SizedBox(height: 16),
            _buildRadioGroup('Business Registered?', _isBusinessRegistered, (value) {
              setState(() {
                _isBusinessRegistered = value;
              });
            }),
            const SizedBox(height: 16),
            _buildFileUploadSection(),
            const SizedBox(height: 16),
            _buildRadioGroup('Device Purchased?', _isDevicePurchased, (value) {
              setState(() {
                _isDevicePurchased = value;
              });
            }),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _saveUserDetailsToFirestore(
                    fullName: _fullNameController.text.trim(),
                    email: _emailController.text.trim(),
                    businessName: _businessNameController.text.trim(),
                    jobTitle: _jobTitle,
                    industryType: _industryType,
                    isBusinessRegistered: _isBusinessRegistered,
                    uploadedFileName: _uploadedFile?.name,
                    isDevicePurchased: _isDevicePurchased,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Details saved successfully!')),
                  );

                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const QrCodeScannerScreen()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              child: const Text(
                'Scan the QR Code on your device to proceed',
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

  Widget _buildDropdown(String label, String currentValue, List<String> options) {
    return DropdownButtonFormField<String>(
      value: currentValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      items: options.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          if (label == 'Job Title') {
            _jobTitle = newValue!;
          } else {
            _industryType = newValue!;
          }
        });
      },
    );
  }

  Widget _buildRadioGroup(String label, bool currentValue, Function(bool) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16.0)),
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                title: const Text('Yes'),
                value: true,
                groupValue: currentValue,
                onChanged: (value) => onChanged(value as bool),
              ),
            ),
            Expanded(
              child: RadioListTile(
                title: const Text('No'),
                value: false,
                groupValue: currentValue,
                onChanged: (value) => onChanged(value as bool),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFileUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Upload certificate', style: TextStyle(fontSize: 16.0)),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: _pickFile,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            side: const BorderSide(color: Colors.blue),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          icon: const Icon(Icons.upload_file),
          label: const Text('Upload'),
        ),
        if (_uploadedFile != null) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.blue),
            ),
            child: Row(
              children: [
                const Icon(Icons.description, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _uploadedFile!.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${(_uploadedFile!.size / 1024).toStringAsFixed(1)} KB',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.check_circle, color: Colors.blue),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
