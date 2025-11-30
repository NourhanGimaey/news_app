import 'package:news/domain/entities/articles_response.dart';

sealed class SearchState {}

class InitialState extends SearchState {}

class LoadingState extends SearchState {
  final String loadingMessage;

  LoadingState({required this.loadingMessage});
}

class ErrorState extends SearchState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}

class EmptyResultsState extends SearchState {
  final String emptyMessage;
  EmptyResultsState({required this.emptyMessage});
}

class SuccessState extends SearchState {
  final List<Articles> articles;
  SuccessState({required this.articles});
}
