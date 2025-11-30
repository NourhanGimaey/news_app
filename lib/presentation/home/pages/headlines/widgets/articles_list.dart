import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/domain/entities/articles_response.dart';
import 'package:news/presentation/home/pages/headlines/cubit/headlines_page_cubit.dart';
import 'package:news/presentation/home/pages/headlines/widgets/article_card.dart';

class ArticlesList extends StatelessWidget {
  final ArticlesResponse? articlesResponse;

  const ArticlesList({super.key, this.articlesResponse});

  @override
  Widget build(BuildContext context) {
    var data = articlesResponse?.articles ?? [];

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        final article = data[index];
        return ArticleCard(
          article: article,
          onTap: () => context.read<HeadlinesPageCubit>().launchArticleUrl(
            article.url ?? '',
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(color: Colors.transparent),
      itemCount: data.length,
    );
  }
}
