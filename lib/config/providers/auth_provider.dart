import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false);

  final storage = SharedPreferences.getInstance();

  Future<void> checkAuthentication() async {
    final SharedPreferences prefs = await storage;
    String? token = prefs.getString("authToken");
    state = token != null && token.isNotEmpty;
  }

  void setState (bool value) {
    state = value;
  }
}