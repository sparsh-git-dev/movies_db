import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies_db/core/helper/debouncer.dart';
import 'package:movies_db/database/local_db_repository/movie_local_data_source.dart';
import 'package:movies_db/database/local_db_repository/movie_local_data_source_impl.dart';
import 'package:movies_db/feature/search_screen/repository/search_movie_repository_impl.dart';
import 'package:movies_db/feature/search_screen/view_model.dart/search_movie_view_model.dart';

import 'package:movies_db/models/movies/movie_model/movie_model.dart';
import 'package:movies_db/service/logger_service.dart';

class SearchViewController extends GetxController {
  static SearchViewController get to => Get.find<SearchViewController>();
  late final TextEditingController searchTextController;
  late final SearchMovieViewModel searchMovieViewModel;
  late final PagingController<int, MovieModel> searchPagingController;

  bool isLoading = true;

  @override
  void onInit() {
    initialiseDependencies();
    super.onInit();
  }

  void handleDisposal() {
    Get.delete<SearchViewController>();
    searchTextController.dispose();
    searchPagingController.dispose();
  }

  void initialiseDependencies() {
    isLoading = true;
    searchPagingController = PagingController(firstPageKey: 1);
    searchTextController = TextEditingController();
    searchMovieViewModel = SearchMovieViewModel(
      searchMovieRepository: SearchMovieRepositoryImpl(
        MovieLocalDataSourceImp(),
      ),
    );
    searchTextController.addListener(() {
      Debouncer(milliseconds: 500).run(() {
        if (searchTextController.text.trim().isNotEmpty) {
          getsearchMovieQuery(query: searchTextController.text, pageKey: 1);
        } else if (searchPagingController.itemList != null &&
            searchPagingController.itemList!.isNotEmpty) {
          searchPagingController.itemList = null;
        }
      });
    });
    searchPagingController.addPageRequestListener((pageKey) {
      getsearchMovieQuery(query: searchTextController.text, pageKey: pageKey);
    });
  }

  Future<void> getsearchMovieQuery({
    required String query,
    required int pageKey,
  }) async {
    try {
      if (query.trim().isEmpty) return;
      final movies = await searchMovieViewModel.fetchSearchedMovies(
        query,
        pageKey,
      );
      final isLastPage = movies.isEmpty;
      if (isLastPage) {
        searchPagingController.appendLastPage(movies);
      } else {
        searchPagingController.appendPage(movies, pageKey + 1);
      }
    } catch (error, stack) {
      LoggerService().logError(error, stack);
      searchPagingController.error = error;
    }
  }
}
