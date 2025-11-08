import 'package:flutter/material.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/core/utils/app_routes.dart';
import 'package:news/data/models/category_model.dart';
import 'package:news/ui/widgets/categories_page.dart';
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
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: AppColors.white,
              child: Center(
                child: Text(
                  "News App",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.home, color: AppColors.white),
              title: Text("Home", style: TextStyle(color: AppColors.white)),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.home.routeName,
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColors.white),
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
