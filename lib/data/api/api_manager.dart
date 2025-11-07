import 'package:dio/dio.dart';
import 'package:news/data/models/articles_response/articles_response.dart';

class ApiManager {
  final dio = Dio();
  final String baseUrl = 'newsapi.org';

  Future<ArticlesResponse> getAllNews() async {
    Uri uri = Uri.https(baseUrl, "/v2/everything", {
      "q": "sports",
      "language": "en",
    });
    var response = await dio.getUri(
      uri,
      options: Options(
        headers: {"Authorization": "02f37c58d5994957b48aa0e232c046cc"},
      ),
    );

    return ArticlesResponse.fromJson(response.data);
  }
}
