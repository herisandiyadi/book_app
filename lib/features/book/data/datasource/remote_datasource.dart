import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/book_model.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class BookRemoteDataSource {
  // ignore: prefer_const_declarations
  static final String _baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  Future<List<BookModel>> fetchBooks({int page = 1, String? query}) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'page': page.toString(),
        if (query != null && query.isNotEmpty) 'search': query,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results
          .map((json) => BookModel.fromJson(_parseBookJson(json)))
          .toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<BookModel> fetchBookDetail(int id) async {
    final uri = Uri.parse('$_baseUrl/$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return BookModel.fromJson(_parseBookJson(data));
    } else {
      throw Exception('Failed to load book detail');
    }
  }

  // Helper to parse Gutendex API JSON to BookModel JSON
  Map<String, dynamic> _parseBookJson(Map<String, dynamic> json) {
    return {
      'id': json['id'],
      'title': json['title'] ?? '',
      'authors': (json['authors'] as List)
          .map((a) => a['name'] as String? ?? '')
          .toList(),
      'cover_image': json['formats']?['image/jpeg'] as String?,
      'description': json['subjects'] != null
          ? (json['subjects'] as List).join(', ')
          : null,
    };
  }
}
