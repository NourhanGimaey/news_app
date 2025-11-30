import 'package:news/data/api/retrofit_api_client.dart';
import 'package:news/data/repository/sources/data_sources/remote/sources_remote_data_source.dart';
import 'package:news/domain/entities/source_response.dart';

// @Injectable(as: SourcesRemoteDataSource)
class SourcesRemoteDataSourcesImpl implements SourcesRemoteDataSource {
  ApiClient apiClient;
  SourcesRemoteDataSourcesImpl({required this.apiClient});

  @override
  Future<SourceResponse> getSources(String categoryId) {
    return apiClient.getSources(categoryId);
  }
}
