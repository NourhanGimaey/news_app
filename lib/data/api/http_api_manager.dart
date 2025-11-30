import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news/data/api/end_points.dart';
import 'package:news/domain/entities/articles_response.dart';
import 'package:news/domain/entities/source_response.dart';

class ApiManager {
  static String baseUrl = 'https://newsapi.org';
  static final String apiKey = dotenv.env['apiKey'] ?? '';

  static Future<SourceResponse> getSources({required String category}) async {
    Uri url = Uri.https(baseUrl, EndPoints.sourceApi, {
      'apiKey': apiKey,
      'category': category,
    });

    try {
      http.Response response = await http.get(url);
      String responseBody = response.body;
      var json = jsonDecode(responseBody);
      SourceResponse sourceResponse = SourceResponse.fromJson(json);
       return sourceResponse;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ArticlesResponse> getArticles({required String source}) async {
    Uri url = Uri.https(baseUrl, EndPoints.articleApi, {
      'apiKey': apiKey,
      "sources": source,
    });

    try {
      var response = await http.get(url);
      String responseBody = response.body;
      return ArticlesResponse.fromJson(jsonDecode(responseBody));
    } catch (e) {
      rethrow;
    }
  }
}
