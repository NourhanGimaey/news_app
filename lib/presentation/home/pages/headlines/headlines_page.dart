import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/domain/category_model.dart';
import 'package:news/domain/entities/articles_entity.dart';
import 'package:news/presentation/home/cubit/headlines_page_state.dart';
import 'package:news/presentation/home/cubit/headlines_page_view_model.dart';
import 'package:news/presentation/home/pages/headlines/widgets/articles_list.dart';

class HeadlinesPage extends StatelessWidget {
  final CategoryModel category;
  const HeadlinesPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HeadlinesPageViewModel(categoryId: category.id),
      child: BlocBuilder<HeadlinesPageViewModel, HeadlinesPageState>(
        builder: (context, state) {
          if (state is ErrorState) {
            return Center(child: Text(state.errorMessage));
          }

          if (state is InitialState || state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SourcesLoadedState) {
            final cubit = context.read<HeadlinesPageViewModel>();
            final sources = state.sourceResponse.sources!;
            
            ArticlesResponse? articlesResponse;
            String? articlesErrorMessage;

            if (state is ArticlesLoadedState) {
              articlesResponse = state.articlesResponse;
            } 

            return Column(
              children: [
                DefaultTabController(
                  length: sources.length,
                  initialIndex: state.selectedIndex,
                  child: TabBar(
                    onTap: cubit.onSourceSelected,
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
                    articlesResponse: articlesResponse,
                    errorMessage: articlesErrorMessage,
                  ),
                ),
              ],
            );
          }
          
          return const SizedBox.shrink();
        },
      ),
    );
  }
}