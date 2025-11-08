import 'package:flutter/material.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/data/api/api_manager.dart';
import 'package:news/data/models/articles_response.dart';
import 'package:news/data/models/category_model.dart';
import 'package:news/data/models/source_response.dart';
import 'package:news/ui/widgets/articles_list.dart';

class NewsPage extends StatefulWidget {
  final CategoryModel category;
  const NewsPage({super.key, required this.category});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  ArticlesResponse? articlesResponse;
  String? errorMessage;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    ApiManager apiManager = ApiManager();
    return Column(
      children: [
        FutureBuilder<SourceResponse?>(
          future: apiManager.getSources(widget.category.id),
          builder: (context, snapshot) {
          if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              var data = snapshot.data;
              if (data == null || data.sources == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (articlesResponse == null && errorMessage == null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    getArticles(data.sources![0].id ?? '');
                  });
                }
                return DefaultTabController(
                  length: data.sources!.length,
                  initialIndex: selectedIndex,
                  child: TabBar(
                    onTap: (index) {
                      selectedIndex = index;
                      getArticles(data.sources![index].id ?? '');
                    },
                    isScrollable: true,
                    indicatorColor: AppColors.white,
                    labelColor: AppColors.white,
                    tabAlignment: TabAlignment.start,
                    dividerColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
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
            articlesResponse: articlesResponse,
            errorMessage: errorMessage,
          ),
        ),
      ],
    );
  }

  Future<void> getArticles(String source) async {
    try {
      articlesResponse = await ApiManager().getArticles(source);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      setState(() {});
    }
  }
}
