import 'package:flutter/material.dart';
import 'package:news/domain/entities/category_model.dart';
import 'package:news/presentation/home/pages/news_headlines/news_page_view_model.dart';
import 'package:news/presentation/home/pages/news_headlines/widgets/articles_list.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatelessWidget {
  final CategoryModel category;
  const NewsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsPageViewModel(categoryId: category.id),
      child: Consumer<NewsPageViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.errorMessage != null &&
              viewModel.sourceResponse == null) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          if (viewModel.sourceResponse == null ||
              viewModel.sourceResponse!.sources == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final sources = viewModel.sourceResponse!.sources!;

          return Column(
            children: [
              DefaultTabController(
                length: sources.length,
                initialIndex: viewModel.selectedIndex,
                child: TabBar(
                  onTap: viewModel.onSourceSelected,
                  isScrollable: true,
                  indicatorColor: Theme.of(context).colorScheme.onSurface,
                  labelColor: Theme.of(context).colorScheme.onSurface,
                  tabAlignment: TabAlignment.start,
                  dividerColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  tabs: sources
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e.name ?? ''),
                        ),
                      )
                      .toList(),
                ),
              ),

              Expanded(
                child: ArticlesList(
                  articlesResponse: viewModel.articlesResponse,
                  errorMessage: viewModel.errorMessage,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
