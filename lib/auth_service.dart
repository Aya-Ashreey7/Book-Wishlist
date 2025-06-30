import 'package:shared_preferences/shared_preferences.dart';

String? currentUserEmail;

bool isLoggedIn() => currentUserEmail != null;

Future<void> loginUser(String email) async {
  currentUserEmail = email;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('currentUserEmail', email);
}

Future<void> logoutUser() async {
  currentUserEmail = null;
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('currentUserEmail');
}

Future<void> loadCurrentUser() async {
  final prefs = await SharedPreferences.getInstance();
  currentUserEmail = prefs.getString('currentUserEmail');
}

