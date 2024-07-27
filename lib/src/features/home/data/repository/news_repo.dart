import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pingo_assignment_app/src/common/di/di.dart';
import 'package:pingo_assignment_app/src/core/api/api_client.dart';
import 'package:pingo_assignment_app/src/features/home/data/model/news_response.dart';

class NewsRepo {
  final Dio _dio = getIt<ApiClient>().dio;

  Future<NewsResponse?> getNews(String country) async {
    try {
      final response = await _dio.get(
        "https://newsapi.org/v2/top-headlines?country=$country&apiKey=${dotenv.get("NEWS_API_KEY")}",
      );

      if (response.statusCode == 200) {
        // Handle the response data
        var data = response.data as Map<String, dynamic>;
        var resp = NewsResponse.fromJson(data);
        return resp;
      } else {
        log('Failed to fetch news. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e, st) {
      log('Error fetching news: $e');
      return null;
    }
  }
}
