import 'package:flutter/material.dart';
import 'package:news/domain/category_model.dart';

class HomeViewModel extends ChangeNotifier {
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
