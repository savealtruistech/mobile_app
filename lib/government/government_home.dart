import 'package:flutter/material.dart';

class GovernmentScreen extends StatelessWidget {
  const GovernmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Government Institution/NGO'),
      ),
      body: const Center(
        child: Text('Welcome to the Government Institution/NGO screen!'),
      ),
    );
  }
}