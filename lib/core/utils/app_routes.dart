import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/presentation/home/screens/home/home_screen.dart';
import 'package:news/presentation/home/screens/search/cubit/search_cubit.dart';
import 'package:news/presentation/home/screens/search/search_screen.dart';

enum AppRoutes {
  home('/'),
  search('search');

  final String routeName;
  const AppRoutes(this.routeName);

  static Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.home.routeName: (context) => const HomeScreen(),
    AppRoutes.search.routeName: (context) => BlocProvider(
      create: (context) => SearchCubit(),
      child: const SearchScreen(),
    ),
  };
}