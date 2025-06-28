import 'package:flutter/material.dart';
import 'global_favorites.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Books')),
      body: favoriteBooks.isEmpty
          ? const Center(child: Text('No favorite books yet.'))
          : ListView.builder(
        itemCount: favoriteBooks.length,
        itemBuilder: (context, index) {
          final book = favoriteBooks[index];
          final isFav = isBookFavorited(book['id'].toString());

          return ListTile(
            leading: Image.network(
              book['image'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(book['title']),
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
          );
        },
      ),
    );
  }
}
