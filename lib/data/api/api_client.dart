import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/data/models/articles_response.dart';
import 'package:news/data/models/source_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @GET("/v2/top-headlines/sources")
  Future<SourceResponse> getSources(@Query("category") String category);
  @GET("/v2/top-headlines")
  Future<ArticlesResponse> getArticles(@Query("sources") String source);
  
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
