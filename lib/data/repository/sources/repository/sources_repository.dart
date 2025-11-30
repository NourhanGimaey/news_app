import 'package:news/domain/entities/source_response.dart';

abstract class SourcesRepository {
  Future<SourceResponse> getSources(String categoryId);
}
