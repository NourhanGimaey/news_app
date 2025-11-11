import 'package:flutter/material.dart';
import 'package:news/data/api/api_client.dart';
import 'package:news/data/models/category_model.dart';
import 'package:news/data/models/source_response.dart';
import 'package:news/providers/news_page_provider.dart';
import 'package:news/ui/widgets/articles_list.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatelessWidget {
  final CategoryModel category;
  const NewsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsPageProvider(),
      child: Consumer<NewsPageProvider>(
        builder: (context, provider, child) => Column(
          children: [
            FutureBuilder<SourceResponse?>(
              future: ApiClient.instance.getSources(category.id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  var data = snapshot.data;
                  if (data == null || data.sources == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (provider.articlesResponse == null &&
                        provider.errorMessage == null) {
                      provider.getArticles(data.sources![0].id ?? '');
                    }
                    return DefaultTabController(
                      length: data.sources!.length,
                      initialIndex: provider.selectedIndex,
                      child: TabBar(
                        onTap: (index) {
                          provider.selectedIndex = index;
                          provider.getArticles(data.sources![index].id ?? '');
                        },
                        isScrollable: true,
                        indicatorColor: Theme.of(context).colorScheme.onSurface,
                        labelColor: Theme.of(context).colorScheme.onSurface,
                        tabAlignment: TabAlignment.start,
                        dividerColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        tabs:
                            data.sources
                                ?.map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e.name ?? ''),
                                  ),
                                )
                                .toList() ??
                            [],
                      ),
                    );
                  }
                }
              },
            ),
            Expanded(
              child: ArticlesList(
                articlesResponse: provider.articlesResponse,
                errorMessage: provider.errorMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
