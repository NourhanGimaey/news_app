import 'package:news/domain/entities/source_response.dart';

abstract class SourcesRemoteDataSource {
    Future<SourceResponse> getSources(String categoryId);

}