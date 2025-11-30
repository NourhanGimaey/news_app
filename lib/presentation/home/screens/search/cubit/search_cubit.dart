import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/api/retrofit_api_client.dart'; // Import the ApiClient
import 'package:news/presentation/home/screens/search/cubit/search_state.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(InitialState());

  final TextEditingController textEditingController = TextEditingController();

  Future<void> searchArticles() async {
    final String searchQuery = textEditingController.text.trim();

    if (searchQuery.isEmpty) {
      emit(InitialState());
      return;
    }

    emit(LoadingState(loadingMessage: 'Searching for "$searchQuery"...'));

    try {
      final articlesResponse = await ApiClient.instance.searchArticles(searchQuery);

      final articles = articlesResponse.articles ?? [];

      if (articles.isEmpty) {
        emit(EmptyResultsState(
            emptyMessage: 'No articles found for "$searchQuery".'));
      } else {
        emit(SuccessState(articles: articles));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: 'Error finding articles: ${e.toString()}'));
    }
  }

  Future<void> launchArticleUrl(String url) async {
    
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }
}