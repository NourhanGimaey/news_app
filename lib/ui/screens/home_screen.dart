import 'package:flutter/material.dart';
import 'package:news/providers/home_page_provider.dart';
import 'package:news/ui/widgets/categories_page.dart';
import 'package:news/ui/widgets/app_drawer.dart';
import 'package:news/ui/widgets/news_page.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageProvider(),
      child: Consumer<HomePageProvider>(
        builder: (context, provider, child) => Scaffold(
          drawer: const AppDrawer(),
          appBar: AppBar(
            title: Text(
              provider.appBarTitle,
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
                onPressed: () {},
              ),
            ],
          ),
          body: provider.currentIndex == -1
              ? CategoriesPage(onCategorySelected: provider.changePage)
              : NewsPage(category: provider.selectedCategory!),
        ),
      ),
    );
  }
}
