import 'package:flutter/material.dart';
import 'package:news/domain/category_model.dart';
import 'package:news/presentation/home/pages/categories/widgets/category_card.dart';

class CategoriesPage extends StatelessWidget {
  final Function(int index, CategoryModel) onCategorySelected;
  const CategoriesPage({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return Text(
              "Good Morning\nHere is Some News For You",
              style: TextStyle(fontSize: 24),
            );
          } else {
            return CategoryCard(
              onCategorySelected: onCategorySelected,
              category: CategoryModel.categories[index - 1],
              index: index - 1,
            );
          }
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: CategoryModel.categories.length + 1,
      ),
    );
  }
}
