class CategoryModel {
  String id;
  String name;
  String image;
  CategoryModel({required this.id, required this.name, required this.image});

  static List<CategoryModel> categories = [
    CategoryModel(
      id: 'general',
      name: 'General',
      image: 'assets/images/general.png',
    ),
    CategoryModel(
      id: 'business',
      name: 'Business',
      image: 'assets/images/business.png',
    ),
    CategoryModel(id: 'sport', name: 'Sport', image: 'assets/images/sport.png'),
    CategoryModel(
      id: 'health',
      name: 'Health',
      image: 'assets/images/health.png',
    ),
    CategoryModel(
      id: 'science',
      name: 'Science',
      image: 'assets/images/science.png',
    ),
    CategoryModel(
      id: 'technology',
      name: 'Technology',
      image: 'assets/images/technology.png',
    ),
    CategoryModel(
      id: 'entertainment',
      name: 'Entertainment',
      image: 'assets/images/entertainment.png',
    ),
  ];
}
