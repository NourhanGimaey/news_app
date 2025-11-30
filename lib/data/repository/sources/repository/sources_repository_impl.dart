import 'package:news/data/repository/sources/data_sources/remote/sources_remote_data_source.dart';
import 'package:news/data/repository/sources/repository/sources_repository.dart';
import 'package:news/domain/entities/source_response.dart';

// @Injectable(as: SourcesRepository)
class SourcesRepositoryImpl implements SourcesRepository {
  SourcesRemoteDataSource sourcesRemoteDataSources;

  SourcesRepositoryImpl({required this.sourcesRemoteDataSources});
  @override
  Future<SourceResponse> getSources(String categoryId) {
    return sourcesRemoteDataSources.getSources(categoryId);
  }
}
