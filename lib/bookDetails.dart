import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'DioService.dart';

class BookDetailsPage extends StatefulWidget {
  final String bookId;

  const BookDetailsPage({super.key, required this.bookId});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  final DioService _dioService = DioService();
  Map<String, dynamic>? _book;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadBookDetails();
  }

  Future<void> _loadBookDetails() async {
    final data = await _dioService.fetchBookDetails(widget.bookId);
    setState(() {
      _book = data;
      _loading = false;
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Could not open link")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_book?['title'] ?? 'Book Details')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row 1: Image + Details
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Book Cover Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            _book!['image'],
                            width: 120,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Book Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _book!['title'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text("Authors: ${_book!['authors']}"),
                              Text("Publisher: ${_book!['publisher']}"),
                              Text("Pages: ${_book!['pages']}"),
                              Text("Year: ${_book!['year']}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Row 2: Description
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _book!['description'] ?? 'No description available.',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 24),

                    // Row 3: Buttons
                    const SizedBox(height: 32),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.open_in_browser),
                            label: const Text('Read Online'),
                            onPressed: () => _launchURL(_book!['url']),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.download),
                            label: const Text('Download'),
                            onPressed: () => _launchURL(_book!['download']),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
