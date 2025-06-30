
import 'package:dio/dio.dart';

class DioService {
  final Dio _dio = Dio();

  // Fetch recent books
  Future<List<dynamic>> fetchRecentBooks() async {
    final response = await _dio.get('https://www.dbooks.org/api/recent');
    return response.data['books'];
  }

  // Fetch book details
  Future<Map<String, dynamic>> fetchBookDetails(String id) async {
    final response = await _dio.get('https://www.dbooks.org/api/book/$id');
    return response.data;
  }

  // Search books
  Future<List<dynamic>> searchBooks(String query) async {
    final response = await _dio.get('https://www.dbooks.org/api/search/$query');
    return response.data['books'];
  }
}
