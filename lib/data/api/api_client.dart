import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/domain/entities/articles_entity.dart';
import 'package:news/domain/entities/source_entity.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  static ApiClient? _instance;
  factory ApiClient(Dio dio) = _ApiClient;

  static get instance {
    if (_instance == null) {
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

      _instance = _ApiClient(dio);
    }
    return _instance!;
  }

  @GET("/v2/top-headlines/sources")
  Future<SourceResponse> getSources(@Query("category") String category);

  @GET("/v2/top-headlines")
  Future<ArticlesResponse> getArticles(@Query("sources") String source);
}
