import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies_db/feature/home_screen/view_model/movie_view_model.dart';
import 'package:movies_db/models/movies/movie_model/movie_model.dart';
import 'package:movies_db/models/trending_movies/trending_movie_model/trending_movie_model.dart';
import 'package:movies_db/database/local_db_repository/movie_local_data_source_impl.dart';
import 'package:movies_db/feature/home_screen/repository/movie_respository_impl.dart';
import 'package:movies_db/feature/home_screen/repository/movies_repository.dart';
import 'package:movies_db/service/logger_service.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get to => Get.find<HomeScreenController>();
  late PagingController<int, TrendingMovieModel> trendingMoviesController;
  late PagingController<int, MovieModel> nowPlayingMoviesController;
  int totalPagesOfTrendingMovies = -1;
  late final MovieRepository movieRepository;
  late final MovieViewModel movieViewModel;
  late final ScrollController? trendingMoviesScroll;

  @override
  void onInit() {
    initialiseDependencies();
    super.onInit();
  }

  void initialiseDependencies() {
    trendingMoviesScroll = ScrollController();
    movieRepository = MovieRepositoryImpl(
      movieLocalDataSource: MovieLocalDataSourceImp(),
    );
    movieViewModel = MovieViewModel(movieRepository: movieRepository);
    trendingMoviesController = PagingController(firstPageKey: 1);
    trendingMoviesController.addPageRequestListener(
      (pageKey) => getTrendingMovies(pageKey: pageKey),
    );
    nowPlayingMoviesController = PagingController(firstPageKey: 1);
    nowPlayingMoviesController.addPageRequestListener(
      (pageKey) => getNowPlayingMovies(pageKey: pageKey),
    );
  }

  Future<void> getTrendingMovies({required int pageKey}) async {
    try {
      final movies = await movieViewModel.fetchTrendingMovies(pageKey);
      final isLastPage = movies.isEmpty;
      if (isLastPage) {
        trendingMoviesController.appendLastPage(movies);
      } else {
        trendingMoviesController.appendPage(movies, pageKey + 1);
      }
    } catch (error, stack) {
      LoggerService().logError(error, stack);
      trendingMoviesController.error = error;
    }
  }

  Future<void> getNowPlayingMovies({required int pageKey}) async {
    try {
      final movies = await movieViewModel.fetchNowPlayingMovies(pageKey);
      final isLastPage = movies.isEmpty;
      if (isLastPage) {
        nowPlayingMoviesController.appendLastPage(movies);
      } else {
        nowPlayingMoviesController.appendPage(movies, pageKey + 1);
      }
    } catch (error, stack) {
      LoggerService().logError(error, stack);
      nowPlayingMoviesController.error = error;
    }
  }

  void refreshScreen() {
    trendingMoviesController.refresh();
    nowPlayingMoviesController.refresh();
    trendingMoviesScroll?.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void handleDisposal() {
    trendingMoviesController.dispose();
    nowPlayingMoviesController.dispose();
    Get.delete<HomeScreenController>();
    LoggerService().logWarning("HomeScreenControlled disposed");
  }
}
