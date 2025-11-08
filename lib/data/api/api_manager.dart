import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/data/models/articles_response.dart';
import 'package:news/data/models/source_response.dart';

class ApiManager {
  final dio = Dio();
  final String baseUrl = 'newsapi.org';
  final String apiKey = dotenv.env['apiKey'] ?? '';

  Future<SourceResponse> getSources(String category) async {
    var uri = Uri.https(baseUrl, "/v2/top-headlines/sources", {
      "category": category,
    });
    var response = await dio.getUri(
      uri,
      options: Options(headers: {"X-Api-Key": apiKey}),
    );
    return SourceResponse.fromJson(response.data);
  }

  Future<ArticlesResponse?> getArticles(String source) async {
    var uri = Uri.https(baseUrl, "/v2/top-headlines", {"sources": source});
    var response = await dio.getUri(
      uri,
      options: Options(headers: {"X-Api-Key": apiKey}),
    );
    return ArticlesResponse.fromJson(response.data);
  }
}
