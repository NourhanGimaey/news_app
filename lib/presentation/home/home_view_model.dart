import 'package:flutter/material.dart';
import 'package:news/domain/entities/category_model.dart';
import 'package:news/presentation/home/home_navigator.dart';

class HomeViewModel extends ChangeNotifier {
  String appBarTitle = "Home";
  int currentIndex = -1;
  CategoryModel? selectedCategory;

  late HomeNavigator navigator;

  void changePage(int index, CategoryModel category) {
    currentIndex = index;
    selectedCategory = CategoryModel.categories[index];
    appBarTitle = selectedCategory!.name;
    notifyListeners();
  }

  void navigateToSearchView() {
    navigator.navigateToSearchView();
  }
}
