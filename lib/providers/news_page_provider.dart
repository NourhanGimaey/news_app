import 'package:flutter/material.dart';
import 'package:news/data/api/api_client.dart';
import 'package:news/data/models/articles_response.dart';

class NewsPageProvider extends ChangeNotifier {
  ArticlesResponse? articlesResponse;
  String? errorMessage;
  int selectedIndex = 0;

  Future<void> getArticles(String source) async {
    try {
      articlesResponse = await ApiClient.instance.getArticles(source);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      articlesResponse = null;
    } finally {
      notifyListeners();
    }
  }
}
