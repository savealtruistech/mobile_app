import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


// Saving the last screen name
Future<void> saveLastScreen(String screenName) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('lastScreen', screenName);
}

// Retrieving the last screen name
Future<String?> getLastScreen() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('lastScreen');
}

// Navigating to the last screen
Future<void> navigateToLastScreen(BuildContext context) async {
  final lastScreen = await getLastScreen();
  if (lastScreen != null) {
    Navigator.pushNamed(context, lastScreen);
  }
}
