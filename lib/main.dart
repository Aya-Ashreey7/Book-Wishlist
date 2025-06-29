import 'package:flutter/material.dart';
import 'DioService.dart';
import 'bookDetails.dart';
import 'global_favorite.dart';
import 'MainLayout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Wishlist',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainLayout(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DioService _dioService = DioService();
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _books = [];
  bool _loading = true;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    setState(() => _loading = true);
    final books = await _dioService.fetchRecentBooks();
    setState(() {
      _books = books;
      _loading = false;
    });
  }

  Future<void> _performSearch(String query) async {
    setState(() => _loading = true);
    final books = await _dioService.searchBooks(query);
    setState(() {
      _books = books;
      _loading = false;
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _fetchBooks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search books...',
            border: InputBorder.none,
          ),
          onSubmitted: (query) {
            if (query.trim().isNotEmpty) {
              _performSearch(query.trim());
            }
          },
        )
            : const Text("All Books"),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: GridView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          itemCount: _books.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final book = _books[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        BookDetailsPage(bookId: book['id'].toString()),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        book['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      right: 8,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              book['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          StatefulBuilder(
                            builder: (context, setLocalState) {
                              final isFav =
                              isBookFavorited(book['id'].toString());
                              return IconButton(
                                icon: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFav ? Colors.red : Colors.white,
                                ),
                                onPressed: () {
                                  setLocalState(() {
                                    toggleFavorite(book);
                                  });
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
