// import 'package:dio/dio.dart';

// class DioService {
//   final Dio _dio = Dio();

//   // Fetch All books
//   Future<List<dynamic>> fetchBooksBybookId(int bookId) async {
//     final response = await _dio.get(
//       'https://www.dbooks.org/api/recent',
//       queryParameters: {'bookId': bookId},
//     );
//     return response.data;
//   }

//   // Bonus: Delete a post by ID
//   // Future<void> deletePost(int postId) async {
//   //   final response = await _dio.delete(
//   //     'https://jsonplaceholder.typicode.com/posts/$postId',
//   //   );
//   //   print('Deleted: ${response.statusCode}'); // Usually returns 200
//   // }
// }

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
