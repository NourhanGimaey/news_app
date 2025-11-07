import 'package:flutter/material.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final int index;
  final CategoryModel category;
  final Function(int index, CategoryModel) onCategorySelected;

  const CategoryCard({super.key, required this.index, required this.category, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    var even = index % 2 == 0;
    return InkWell(
      onTap: (){
        onCategorySelected(index, category);
      },
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(category.image)),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: even
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                category.name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withAlpha(90),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(84),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (even)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        even ? Icons.arrow_forward_ios : Icons.arrow_back_ios_new,
                        color: AppColors.white,
                      ),
                    ),
                    if (!even)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
