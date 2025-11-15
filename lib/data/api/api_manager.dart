import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/domain/entities/articles_entity.dart';
import 'package:news/domain/entities/source_entity.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Deprecated("Migrated to retrofit ApiClient instead")
class ApiManager {
  late Dio dio = buildDioObject();
  final String baseUrl = 'newsapi.org';

  Future<SourceResponse> getSources(String category) async {
    var uri = Uri.https(baseUrl, "/v2/top-headlines/sources", {
      "category": category,
    });
    var response = await dio.getUri(uri);
    return SourceResponse.fromJson(response.data);
  }

  Future<ArticlesResponse?> getArticles(String source) async {
    var uri = Uri.https(baseUrl, "/v2/top-headlines", {"sources": source});
    var response = await dio.getUri(uri);
    return ArticlesResponse.fromJson(response.data);
  }
}

Dio buildDioObject() {
    final String apiKey = dotenv.env['apiKey'] ?? '';
    Dio dio = Dio();
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
