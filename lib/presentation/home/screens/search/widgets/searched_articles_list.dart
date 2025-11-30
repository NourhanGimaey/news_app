import 'package:flutter/material.dart';
import 'package:news/domain/entities/articles_response.dart';
import 'package:news/presentation/home/pages/headlines/widgets/article_card.dart';

class SearchedArticlesList extends StatelessWidget {
  final List<Articles> articles;

  const SearchedArticlesList({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    var data = articles;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      itemBuilder: (context, index) {
        return ArticleCard(article: data[index]);
      },
      separatorBuilder: (context, index) =>
          const Divider(color: Colors.transparent),
      itemCount: data.length,
    );
  }
}
