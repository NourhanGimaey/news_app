import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/domain/entities/articles_response.dart';
import 'package:news/presentation/home/pages/headlines/widgets/article_card.dart';
import 'package:news/presentation/home/screens/search/cubit/search_cubit.dart';

class SearchedArticlesList extends StatelessWidget {
  final List<Articles> articles;

  const SearchedArticlesList({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    var data = articles;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      itemBuilder: (context, index) {
        final article = data[index];
        return ArticleCard(
          article: article,
          onTap: () =>
              context.read<SearchCubit>().launchArticleUrl(article.url ?? ''),
        );
      },
      separatorBuilder: (context, index) =>
          const Divider(color: Colors.transparent),
      itemCount: data.length,
    );
  }
}
