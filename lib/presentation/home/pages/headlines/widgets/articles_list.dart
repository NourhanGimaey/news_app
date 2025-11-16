import 'package:flutter/material.dart';
import 'package:news/domain/entities/articles_entity.dart';
import 'package:news/presentation/home/pages/headlines/widgets/article_card.dart';

class ArticlesList extends StatelessWidget {
  final ArticlesResponse? articlesResponse;
  final String? errorMessage;

  const ArticlesList({super.key, this.articlesResponse, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    if (errorMessage == null && articlesResponse == null) {
      return Center(child: CircularProgressIndicator());
    } else if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    } else {
      var data = articlesResponse?.articles ?? [];

      if (data.isEmpty) {
        return Center(child: Text("No articles found."));
      }

      return ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          return ArticleCard(article: data[index]);
        },
        separatorBuilder: (context, index) =>
            Divider(color: Colors.transparent),
        itemCount: data.length,
      );
    }
  }
}
