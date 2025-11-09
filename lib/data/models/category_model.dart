class CategoryModel {
  String id;
  String name;
  String? imageDark;
  String? imageLight;

  CategoryModel({
    required this.id,
    required this.name,
    this.imageDark,
    this.imageLight,
  });

  static List<CategoryModel> categories = [
    CategoryModel(
      id: 'general',
      name: 'General',
      imageDark: 'assets/images/general.png',
      imageLight: 'assets/images/general_dark.png',
    ),
    CategoryModel(
      id: 'business',
      name: 'Business',
      imageDark: 'assets/images/business.png',
      imageLight: 'assets/images/busniess_dark.png',
    ),
    CategoryModel(
      id: 'sports',
      name: 'Sports',
      imageDark: 'assets/images/sport.png',
      imageLight: 'assets/images/sport_dark.png',
    ),
    CategoryModel(
      id: 'health',
      name: 'Health',
      imageDark: 'assets/images/health.png',
      imageLight: 'assets/images/health_dark.png',
    ),
    CategoryModel(
      id: 'science',
      name: 'Science',
      imageDark: 'assets/images/science.png',
      imageLight: 'assets/images/science_dark.png',
    ),
    CategoryModel(
      id: 'technology',
      name: 'Technology',
      imageDark: 'assets/images/technology.png',
      imageLight: 'assets/images/technology_dark.png',
    ),
    CategoryModel(
      id: 'entertainment',
      name: 'Entertainment',
      imageDark: 'assets/images/entertainment.png',
      imageLight: 'assets/images/entertainment_dark.png',
    ),
  ];
}
