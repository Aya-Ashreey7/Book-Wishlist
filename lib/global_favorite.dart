List<Map<String, dynamic>> favoriteBooks = [];

void toggleFavorite(Map<String, dynamic> book) {
  final exists = favoriteBooks.any((b) => b['id'] == book['id']);
  if (exists) {
    favoriteBooks.removeWhere((b) => b['id'] == book['id']);
  } else {
    favoriteBooks.add(book);
  }
}

bool isBookFavorited(String bookId) {
  return favoriteBooks.any((b) => b['id'].toString() == bookId);
}
