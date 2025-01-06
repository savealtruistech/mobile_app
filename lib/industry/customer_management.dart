import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'registration_progress_tracker.dart';
class CustomerManagementScreen extends StatefulWidget {
  const CustomerManagementScreen({super.key});

  @override
  CustomerManagementScreenState createState() =>
      CustomerManagementScreenState();
}

class CustomerManagementScreenState extends State<CustomerManagementScreen> {
  final List<CustomerProfile> _customerProfiles = [];
  final List<bool> _isExpandedList = [];

  @override
  void initState() {
    super.initState();
    _loadExistingCustomerProfiles();
  }

  @override
  void dispose() {
    saveLastScreen('CustomerManagementScreen');
    super.dispose();
  }

  Future<void> _loadExistingCustomerProfiles() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final String userId = user.uid;
    final DocumentReference userDoc =
    FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      final docSnapshot = await userDoc.get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final existingProfiles = (data['customerProfiles'] as List<dynamic>?)
            ?.map((profileData) => CustomerProfile.fromMap(profileData))
            .toList();

        if (existingProfiles != null) {
          setState(() {
            _customerProfiles.clear();
            _isExpandedList.clear();
            _customerProfiles.addAll(existingProfiles);
            _isExpandedList.addAll(
              List<bool>.filled(_customerProfiles.length, false),
            );
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading profiles: $e')),
      );
    }
  }

  Future<void> _deleteProfile(int index) async {
    setState(() {
      _customerProfiles.removeAt(index);
      _isExpandedList.removeAt(index);
    });
    await _saveCustomerProfilesToFirestore();
  }

  Future<void> _saveCustomerProfilesToFirestore() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final String userId = user.uid;
    final DocumentReference userDoc =
    FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      List<Map<String, dynamic>> customerProfiles =
      _customerProfiles.map((profile) => profile.toMap()).toList();
      await userDoc.set({'customerProfiles': customerProfiles},
          SetOptions(merge: true));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving profiles: $e')),
      );
    }
  }

  void _editProfile(int index) {
    final profile = _customerProfiles[index];
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nameController =
        TextEditingController(text: profile.businessName);
        final TextEditingController countryController =
        TextEditingController(text: profile.country);
        final TextEditingController cityController =
        TextEditingController(text: profile.city);
        final TextEditingController addressController =
        TextEditingController(text: profile.address);

        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Business Name'),
              ),
              TextField(
                controller: countryController,
                decoration: const InputDecoration(labelText: 'Country'),
              ),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  profile.businessName = nameController.text;
                  profile.country = countryController.text;
                  profile.city = cityController.text;
                  profile.address = addressController.text;
                });
                _saveCustomerProfilesToFirestore();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Management'),
      ),
      body: _customerProfiles.isEmpty
          ? const Center(child: Text('No profiles found.'))
          : ListView.builder(
        key: const PageStorageKey('customer_profiles_list'),
        itemCount: _customerProfiles.length,
        itemBuilder: (context, index) {
          final profile = _customerProfiles[index];
          return ExpansionPanelList(
            expansionCallback: (int panelIndex, bool isExpanded) {
              setState(() {
                _isExpandedList[index] = !isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(profile.businessName ?? 'Unknown'),
                  );
                },
                body: Column(
                  children: [
                    ListTile(
                      title: Text('Country: ${profile.country ?? ''}'),
                    ),
                    ListTile(
                      title: Text('City: ${profile.city ?? ''}'),
                    ),
                    ListTile(
                      title: Text('Address: ${profile.address ?? ''}'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon:
                          const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editProfile(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete,
                              color: Colors.red),
                          onPressed: () => _deleteProfile(index),
                        ),
                      ],
                    ),
                  ],
                ),
                isExpanded: _isExpandedList[index],
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomerProfile {
  String? businessName;
  String? country;
  String? city;
  String? address;

  CustomerProfile({this.businessName, this.country, this.city, this.address});

  Map<String, dynamic> toMap() {
    return {
      'businessName': businessName,
      'country': country,
      'city': city,
      'address': address,
    };
  }

  factory CustomerProfile.fromMap(Map<String, dynamic> map) {
    return CustomerProfile(
      businessName: map['businessName'] as String?,
      country: map['country'] as String?,
      city: map['city'] as String?,
      address: map['address'] as String?,
    );
  }
}

