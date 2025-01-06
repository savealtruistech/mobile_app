import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  RoleSelectionScreenState createState() => RoleSelectionScreenState();
}

class RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Role Selection',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Your Role',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              'To complete the sign-up process, please select your account type.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 15),
            _buildRoleOption('Manufacturing Industry', 'lorem ipsum dolor sit amet', 'manufacturing'),
            const SizedBox(height: 15),
            _buildRoleOption('Environmental Consultant', 'lorem ipsum dolor sit amet', 'consultant'),
            const SizedBox(height: 15),
            _buildRoleOption('Government Institution/NGO', 'lorem ipsum dolor sit amet', 'government'),
            const SizedBox(height: 15),
            _buildRoleOption('Concerned Citizen', 'lorem ipsum dolor sit amet', 'citizen'),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedRole != null) {
                    await _saveRoleToFirestore(selectedRole!);
                    if (mounted) {
                      Navigator.pushNamed(
                        context,
                        _getDestinationRoute(selectedRole!),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleOption(String title, String description, String value) {
    return ListTile(
      leading: const Icon(Icons.flash_on, color: Colors.blueAccent),
      title: Text(title),
      subtitle: Text(description),
      trailing: Radio<String>(
        value: value,
        groupValue: selectedRole,
        onChanged: (String? value) {
          setState(() {
            selectedRole = value;
          });
        },
      ),
      onTap: () {
        setState(() {
          selectedRole = value;
        });
      },
    );
  }

  String _getDestinationRoute(String role) {
    switch (role) {
      case 'manufacturing':
        return '/industryhome';
      case 'consultant':
        return '/consultanthome';
      case 'government':
        return '/governmenthome';
      case 'citizen':
        return '/citizenhome';
      default:
        return '/';
    }
  }

  Future<void> _saveRoleToFirestore(String role) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User is not logged in')),
        );
      }
      return;
    }

    final String userId = user.uid; // Current user's ID
    final CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      await users.doc(userId).set({
        'role': role,
        'timestamp': FieldValue.serverTimestamp(),
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Role saved successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving role: $e')),
        );
      }
    }
  }

}
