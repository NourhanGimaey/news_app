import 'package:news/domain/entities/articles_entity.dart';
import 'package:news/domain/entities/source_entity.dart';

sealed class HeadlinesPageState {}

class InitialState extends HeadlinesPageState {}

class LoadingState extends HeadlinesPageState {
  final String message;

  LoadingState(this.message);
}

class ErrorState extends HeadlinesPageState {
  final String errorMessage;

  ErrorState(this.errorMessage);
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
