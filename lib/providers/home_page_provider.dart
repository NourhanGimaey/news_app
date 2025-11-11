import 'package:flutter/material.dart';
import 'package:news/data/models/category_model.dart';

class HomePageProvider extends ChangeNotifier {
  String appBarTitle = "Home";
  int currentIndex = -1;
  CategoryModel? selectedCategory;

  void changePage(int index, CategoryModel category) {
    currentIndex = index;
    selectedCategory = CategoryModel.categories[index];
    appBarTitle = selectedCategory!.name;
    notifyListeners();
  }
}
