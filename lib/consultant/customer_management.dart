import 'package:flutter/material.dart';

class CustomerManagementScreen extends StatefulWidget {
  const CustomerManagementScreen({super.key});

  @override
  CustomerManagementScreenState createState() =>
      CustomerManagementScreenState();
}

class CustomerManagementScreenState extends State<CustomerManagementScreen> {
  final List<CustomerProfile> _customerProfiles = [];
  final List<String> _countries = ['Rwanda', 'Kenya', 'Uganda']; // Confirm countries of operation and proposed expansion with Kareem
  final List<String> _cities = ['Kigali', 'Nairobi', 'Kampala']; //Matching cities
  String? _estimatedCustomers;
  final List<String> _customerRanges = ['0 - 50', '50 - 100', '100 - 150'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fill in the data for your profile. It will take a couple of minutes.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Estimated number of customers',
                border: OutlineInputBorder(),
              ),
              value: _estimatedCustomers,
              onChanged: (value) {
                setState(() {
                  _estimatedCustomers = value;
                });
              },
              items: _customerRanges
                  .map((range) => DropdownMenuItem(
                value: range,
                child: Text(range),
              ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Customer'),
              onPressed: () {
                setState(() {
                  _customerProfiles.add(CustomerProfile());
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _customerProfiles.length,
                itemBuilder: (context, index) {
                  return CustomerProfileForm(
                    key: ValueKey(_customerProfiles[index]),
                    profile: _customerProfiles[index],
                    countries: _countries,
                    cities: _cities,
                    onRemove: () {
                      setState(() {
                        _customerProfiles.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50), // Make button full width
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                // Save to DB
              },

              child: const Text('Save'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50), // Make button full width
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                // Close
              },

              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerProfileForm extends StatelessWidget {
  final CustomerProfile profile;
  final List<String> countries;
  final List<String> cities;
  final VoidCallback onRemove;

  const CustomerProfileForm({
    super.key,
    required this.profile,
    required this.countries,
    required this.cities,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Customer Profiles', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name of Customer',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                profile.businessName = value;
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
              ),
              value: profile.country,
              onChanged: (value) {
                profile.country = value;
              },
              items: countries
                  .map((country) => DropdownMenuItem(
                value: country,
                child: Text(country),
              ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
              value: profile.city,
              onChanged: (value) {
                profile.city = value;
              },
              items: cities
                  .map((city) => DropdownMenuItem(
                value: city,
                child: Text(city),
              ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                profile.address = value;
              },
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onRemove,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerProfile {
  String? businessName;
  String? country;
  String? city;
  String? address;

  CustomerProfile({
    this.businessName,
    this.country,
    this.city,
    this.address,
  });
}
