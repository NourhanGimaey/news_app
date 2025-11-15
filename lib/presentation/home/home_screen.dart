import 'package:flutter/material.dart';
import 'package:news/core/utils/app_routes.dart';
import 'package:news/presentation/home/home_view_model.dart';
import 'package:news/presentation/home/pages/news_categories/widgets/categories_page.dart';
import 'package:news/presentation/home/widgets/app_drawer.dart';
import 'package:news/presentation/home/pages/news_headlines/news_page.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          drawer: const AppDrawer(),
          appBar: AppBar(
            title: Text(
              viewModel.appBarTitle,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.search.routeName);
                },
              ),
            ],
          ),
          body: viewModel.currentIndex == -1
              ? CategoriesPage(onCategorySelected: viewModel.changePage)
              : NewsPage(category: viewModel.selectedCategory!),
        ),
      ),
    );
  }
}
