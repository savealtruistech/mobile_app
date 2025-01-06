import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _currentUserId;

  String? get currentUserId => _currentUserId;

  // Set the current user ID when they log in
  void setUserId(String userId) {
    _currentUserId = userId;
    notifyListeners();
  }

  // Clear the user session when they log out
  void clearUserId() {
    _currentUserId = null;
    notifyListeners();
  }
}
