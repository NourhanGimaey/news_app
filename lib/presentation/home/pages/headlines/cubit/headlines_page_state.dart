import 'package:news/domain/entities/articles_response.dart';
import 'package:news/domain/entities/source_response.dart';

sealed class HeadlinesPageState {}

class InitialState extends HeadlinesPageState {}

class LoadingState extends HeadlinesPageState {
  final String loadingMessage;

  LoadingState({required this.loadingMessage});
}

class ErrorState extends HeadlinesPageState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}

class SourcesLoadedState extends HeadlinesPageState {
  final SourceResponse sourceResponse;
  final int selectedIndex;

  SourcesLoadedState(this.sourceResponse, this.selectedIndex);
}

class ArticlesLoadedState extends SourcesLoadedState {
  final ArticlesResponse articlesResponse;

  ArticlesLoadedState(
    super.sourceResponse,
    super.selectedIndex,
    this.articlesResponse,
  );
}
