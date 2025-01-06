import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'qr_code.dart';

class BusinessRegistrationScreen extends StatefulWidget {
  const BusinessRegistrationScreen({super.key});

  @override
  BusinessRegistrationScreenState createState() => BusinessRegistrationScreenState();
}

class BusinessRegistrationScreenState extends State<BusinessRegistrationScreen> {

  bool _isBusinessRegistered = true;
  bool _isDevicePurchased = true;
  PlatformFile? _uploadedFile;

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
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const QrCodeScannerScreen()),
                );
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
