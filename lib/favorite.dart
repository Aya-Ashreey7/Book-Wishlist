import 'package:book_wishlist/main.dart';
import 'package:flutter/material.dart';
import 'global_favorite.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MyHomePage()),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          'Favorite Books',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: favoriteBooks.isEmpty
          ? const Center(child: Text('No favorite books yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoriteBooks.length,
              itemBuilder: (context, index) {
                final book = favoriteBooks[index];
                final isFav = isBookFavorited(book['id'].toString());

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        book['image'],
                        width: 70,
                        height: 100,
                        fit: BoxFit.fill, // Shows full image
                      ),
                    ),
                    title: Text(
                      book['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          toggleFavorite(book);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
