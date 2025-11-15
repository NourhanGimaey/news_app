import 'package:flutter/material.dart';
import 'package:news/presentation/home/home_screen.dart';
import 'package:news/presentation/search/search_screen.dart';

enum AppRoutes {
  home('/'),
  search('search');

  final String routeName;
  const AppRoutes(this.routeName);

  static Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.home.routeName: (context) => const HomeScreen(),
    AppRoutes.search.routeName: (context) => const SearchScreen(),
  };
}
