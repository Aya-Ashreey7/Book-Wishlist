import 'auth_service.dart';

Map<String, List<Map<String, dynamic>>> userFavorites = {};

bool isBookFavorited(String bookId) {
  if (!isLoggedIn()) return false;
  return userFavorites[currentUserEmail]?.any((book) => book['id'].toString() == bookId) ?? false;
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
}

List<Map<String, dynamic>> get favoriteBooks =>
    userFavorites[currentUserEmail] ?? [];
