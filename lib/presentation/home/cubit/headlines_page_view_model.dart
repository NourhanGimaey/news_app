import 'package:news/data/api/api_client.dart';
import 'package:news/presentation/home/cubit/headlines_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeadlinesPageViewModel extends Cubit<HeadlinesPageState> {
  final String categoryId;

  HeadlinesPageViewModel({required this.categoryId}) : super(InitialState()) {
    getSources();
  }

  Future<void> getSources() async {
    emit(LoadingState('Loading...'));
    try {
      final sourceResponse = await ApiClient.instance.getSources(categoryId);

      if (sourceResponse?.sources != null &&
          sourceResponse!.sources!.isNotEmpty) {
        emit(SourcesLoadedState(sourceResponse, 0));
        await getArticles(sourceResponse.sources![0].id ?? '');
      }
    } catch (e) {
      emit(ErrorState('Error fetching sources: ${e.toString()}'));
    }
  }

  Future<void> getArticles(String sourceId) async {
    if (state is SourcesLoadedState) {
      final currentState = state as SourcesLoadedState;
      emit(LoadingState('Loading...'));

      try {
        final articlesResponse = await ApiClient.instance.getArticles(sourceId);

        emit(
          ArticlesLoadedState(
            currentState.sourceResponse,
            currentState.selectedIndex,
            articlesResponse!,
          ),
        );
      } catch (e) {
        emit(ErrorState('Error fetching articles: ${e.toString()}'));
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
}
