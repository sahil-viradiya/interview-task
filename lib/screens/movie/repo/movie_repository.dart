import 'dart:developer';

import 'package:dio/dio.dart';

class MovieRepository {
  final Dio _dio = Dio();
  final String apiKey = "396c38b8f8fdb4d5ff70625ade527611"; // Replace with your TMDB API key

  Future<List> searchMovies(String query, int page) async {
    log("page----${page}");
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/search/movie',
        queryParameters: {
          'api_key': apiKey,
          'query': query,
          'page': page,
        },
      );
      return response.data['results'];
    } catch (e) {
      throw Exception('Failed to load movies');
    }
  }
}
