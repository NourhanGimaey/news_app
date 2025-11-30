import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/domain/entities/articles_response.dart';
import 'package:news/domain/entities/source_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Deprecated("Migrated to retrofit ApiClient instead")
class ApiManager {
  late Dio dio = buildDioObject();

  Future<SourceResponse> getSources(String category) async {
    try {
      var response = await dio.get(
        "/v2/top-headlines/sources",
        queryParameters: {"category": category},
      );
      return SourceResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ArticlesResponse?> getArticles(String source) async {
    try {
      var response = await dio.get(
        "/v2/top-headlines",
        queryParameters: {"sources": source},
      );
      return ArticlesResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Articles>> searchArticles(String q) async {
    try {
      var searchResponse = await dio.get(
        "/v2/everything",
        queryParameters: {"q": q},
      );
      return ArticlesResponse.fromJson(searchResponse.data).articles ?? [];
    } catch (e) {
      rethrow;
    }
  }
}

Dio buildDioObject() {
  final String apiKey = dotenv.env['apiKey'] ?? '';
  final Dio dio = Dio();
  dio.options = BaseOptions(
    baseUrl: 'https://newsapi.org',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {"X-Api-Key": apiKey},
  );

  dio.interceptors.add(
    PrettyDioLogger(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
      responseBody: true,
    ),
  );
  return dio;
}
