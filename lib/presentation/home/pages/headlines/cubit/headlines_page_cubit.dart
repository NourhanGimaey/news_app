import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/api/retrofit_api_client.dart';
import 'package:news/presentation/home/pages/headlines/cubit/headlines_page_state.dart';
import 'package:url_launcher/url_launcher.dart';

// @injectable
class HeadlinesPageCubit extends Cubit<HeadlinesPageState> {
  final String categoryId;
  // late SourcesRepository sourcesRepository;

  HeadlinesPageCubit({required this.categoryId}) : super(InitialState()) {
    getSources(categoryId);
  }

  Future<void> getSources(categoryId) async {
    try {
      emit(LoadingState(loadingMessage: 'Loading...'));

      final sourceResponse = await ApiClient.instance.getSources(categoryId);

      // final sourceResponse = await sourcesRepository.getSources(categoryId);

      if (sourceResponse.sources != null &&
          sourceResponse.sources!.isNotEmpty) {
        emit(SourcesLoadedState(sourceResponse, 0));
        await getArticles(sourceResponse.sources![0].id ?? '');
      }
    } catch (e) {
      emit(ErrorState(errorMessage: 'Error fetching sources: ${e.toString()}'));
    }
  }

  Future<void> getArticles(String sourceId) async {
    if (state is SourcesLoadedState) {
      final currentState = state as SourcesLoadedState;

      try {
        emit(LoadingState(loadingMessage: 'Loading...'));
        final articlesResponse = await ApiClient.instance.getArticles(sourceId);

        emit(
          ArticlesLoadedState(
            currentState.sourceResponse,
            currentState.selectedIndex,
            articlesResponse!,
          ),
        );
      } catch (e) {
        emit(
          ErrorState(errorMessage: 'Error fetching articles: ${e.toString()}'),
        );
      }
    }
  }

  void onSourceSelected(int index) {
    if (state is SourcesLoadedState) {
      final currentState = state as SourcesLoadedState;

      if (currentState.selectedIndex == index) return;

      final selectedSourceId = currentState.sourceResponse.sources?[index].id;

      emit(SourcesLoadedState(currentState.sourceResponse, index));

      if (selectedSourceId != null) {
        getArticles(selectedSourceId);
      }
    }
  }

  Future<void> launchArticleUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }
}
