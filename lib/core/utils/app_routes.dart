import 'package:flutter/material.dart';
import 'package:news/ui/home/home_screen.dart';

enum AppRoutes {
  home('/');

  final String routeName;
  const AppRoutes(this.routeName);

  static Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.home.routeName: (context) => const HomeScreen(),
  };
}
