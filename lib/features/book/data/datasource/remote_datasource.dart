import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/book_model.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class BookRemoteDataSource {
  final String baseUrl;
  final http.Client httpClient;

  BookRemoteDataSource({String? baseUrl, http.Client? httpClient})
    : baseUrl = baseUrl ?? dotenv.env['API_BASE_URL'] ?? '',
      httpClient = httpClient ?? http.Client();

  Future<List<BookModel>> fetchBooks({int page = 1, String? query}) async {
    final uri = Uri.parse(baseUrl).replace(
      queryParameters: {
        'page': page.toString(),
        if (query != null && query.isNotEmpty) 'search': query,
      },
    );

    final response = await httpClient.get(uri);

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
    final uri = Uri.parse('$baseUrl/$id');
    final response = await httpClient.get(uri);

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
          .map(
            (a) => {
              'name': a['name'] ?? '',
              'birthYear': a['birth_year'],
              'deathYear': a['death_year'],
            },
          )
          .toList(),
      'cover_image': json['formats']?['image/jpeg'] as String?,
      'description': json['subjects'] != null
          ? (json['subjects'] as List).join(', ')
          : null,
      'summaries': json['summaries'] != null
          ? List<String>.from(json['summaries'])
          : null,
      'translators': json['translators'] != null
          ? List<String>.from(json['translators'].map((t) => t['name'] ?? ''))
          : null,
      'subjects': json['subjects'] != null
          ? List<String>.from(json['subjects'])
          : null,
      'bookshelves': json['bookshelves'] != null
          ? List<String>.from(json['bookshelves'])
          : null,
      'languages': json['languages'] != null
          ? List<String>.from(json['languages'])
          : null,
      'copyright': json['copyright'],
      'mediaType': json['media_type'],
      'formats': json['formats'] != null
          ? Map<String, String>.from(json['formats'])
          : null,
      'downloadCount': json['download_count'],
    };
  }
}
