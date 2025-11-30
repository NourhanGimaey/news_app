import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/presentation/home/screens/search/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(InitialState());

  final TextEditingController textEditingController = TextEditingController();

  Future<void> searchArticles() async {
    final String searchQuery = textEditingController.text.trim();

    if (searchQuery.isEmpty) {
      emit(InitialState());
      return;
    }

    try {
      // check if article.title contains searchQuery
      // emit(SuccessState());
    } catch (e) {
      emit(ErrorState(errorMessage: 'Error finding articles: ${e.toString()}'));
    }
  }
}
