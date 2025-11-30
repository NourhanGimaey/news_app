import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/presentation/home/screens/search/cubit/search_cubit.dart';
import 'package:news/presentation/home/screens/search/cubit/search_state.dart';
import 'package:news/presentation/home/screens/search/widgets/searched_articles_list.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: cubit.textEditingController,
                onSubmitted: (value) {
                  cubit.searchArticles();
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ErrorState) {
                      return Center(child: Text(state.errorMessage));
                    } else if (state is SuccessState) {
                      return SearchedArticlesList(articles: state.articles);
                    } else if (state is EmptyResultsState) {
                      return Center(child: Text(state.emptyMessage));
                    }
                    return const Center(
                      child: Text('Enter a keyword to search for articles.'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
