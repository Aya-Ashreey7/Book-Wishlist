import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_service.dart';

Map<String, List<Map<String, dynamic>>> userFavorites = {};

Future<void> loadFavorites() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonStr = prefs.getString('favorites');
  if (jsonStr != null) {
    final data = json.decode(jsonStr) as Map<String, dynamic>;
    userFavorites = data.map((email, books) =>
        MapEntry(email, List<Map<String, dynamic>>.from(books)));
  }
}

Future<void> saveFavorites() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('favorites', json.encode(userFavorites));
}

void toggleFavorite(Map<String, dynamic> book) {
  if (!isLoggedIn()) return;

  final favList = userFavorites[currentUserEmail] ?? [];

  final exists = favList.any((b) => b['id'].toString() == book['id'].toString());
  if (exists) {
    favList.removeWhere((b) => b['id'].toString() == book['id'].toString());
  } else {
    favList.add(book);
  }

  userFavorites[currentUserEmail!] = favList;
  saveFavorites(); // Persist
}

bool isBookFavorited(String bookId) {
  if (!isLoggedIn()) return false;
  return userFavorites[currentUserEmail]?.any((b) => b['id'].toString() == bookId) ?? false;
}

List<Map<String, dynamic>> get favoriteBooks =>
    userFavorites[currentUserEmail] ?? [];
