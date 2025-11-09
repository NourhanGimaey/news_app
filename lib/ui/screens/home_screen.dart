import 'package:flutter/material.dart';
import 'package:news/data/models/category_model.dart';
import 'package:news/ui/widgets/categories_page.dart';
import 'package:news/ui/widgets/app_drawer.dart';
import 'package:news/ui/widgets/news_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String appBarTitle = "Home";
  int currentIndex = -1;
  CategoryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(
          appBarTitle,
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
      body: currentIndex == -1
          ? CategoriesPage(onCategorySelected: changePage)
          : NewsPage(category: selectedCategory!),
    );
  }

  void changePage(int index, CategoryModel category) {
    currentIndex = index;
    selectedCategory = CategoryModel.categories[index];
    appBarTitle = selectedCategory!.name;
    setState(() {});
  }
}
