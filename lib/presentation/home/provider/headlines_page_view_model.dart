import 'package:flutter/material.dart';
import 'package:news/data/api/api_client.dart';
import 'package:news/domain/entities/articles_entity.dart';
import 'package:news/domain/entities/source_entity.dart';

class HeadlinesPageViewModel extends ChangeNotifier {
  final String categoryId;
  SourceResponse? sourceResponse;
  ArticlesResponse? articlesResponse;
  String? errorMessage;
  int selectedIndex = 0;

  HeadlinesPageViewModel({required this.categoryId}) {
    getSources();
  }

  Future<void> getSources() async {
    try {
      sourceResponse = await ApiClient.instance.getSources(categoryId);

      if (sourceResponse?.sources != null &&
          sourceResponse!.sources!.isNotEmpty) {
        getArticles(sourceResponse!.sources![selectedIndex].id ?? '');
      }
    } catch (e) {
      errorMessage = 'Error fetching sources: ${e.toString()}';
    } finally {
      notifyListeners();
    }
  }

  Future<void> getArticles(String source) async {
    try {
      articlesResponse = await ApiClient.instance.getArticles(source);
    } catch (e) {
      errorMessage = 'Error fetching articles: ${e.toString()}';
      articlesResponse = null;
    } finally {
      notifyListeners();
    }
  }

  void onSourceSelected(int index) {
    if (selectedIndex == index) return;

    selectedIndex = index;
    notifyListeners();

    final selectedSourceId = sourceResponse?.sources?[index].id;
    if (selectedSourceId != null) {
      getArticles(selectedSourceId);
    }
  }
}
