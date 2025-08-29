import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:movies_db/models/movies/movie_list_response_model/movie_list_response_model.dart';
import 'package:movies_db/models/movies/movie_model/movie_model.dart';
import 'package:movies_db/models/trending_movies/trending_movie_list_response_model/trending_movie_list_response_model.dart';
import 'package:movies_db/models/trending_movies/trending_movie_model/trending_movie_model.dart';
import 'package:movies_db/database/local_db_repository/movie_local_data_source.dart';
import 'package:movies_db/feature/home_screen/repository/movies_repository.dart';
import 'package:movies_db/service/logger_service.dart';
import 'package:movies_db/service_locator.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieLocalDataSource movieLocalDataSource;
  const MovieRepositoryImpl({required this.movieLocalDataSource});

  @override
  Future<List<TrendingMovieModel>> getTrendingMovies(int page) async {
    try {
      List<TrendingMovieModel> localMovies = await movieLocalDataSource
          .getTrendingMovies(page);
      if (localMovies.isNotEmpty) return localMovies;
      bool internetAccess = await InternetConnection().hasInternetAccess;
      if (!internetAccess) {
        LoggerService().logError("No internet");
        return [];
      }
      final TrendingMovieListResponseModel? response = await apiService
          .getTrendingMovies(page);
      if (response == null) return [];
      await movieLocalDataSource.saveTrendingMovies(page, response.results);
      return response.results;
    } catch (e, stack) {
      LoggerService().logError(e, stack);
      return [];
    }
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies(int page) async {
    try {
      List<MovieModel> localMovies = await movieLocalDataSource
          .getNowPlayingMovies(page);
      if (localMovies.isNotEmpty) return localMovies;
      bool internetAccess = await InternetConnection().hasInternetAccess;
      if (!internetAccess) {
        LoggerService().logError("No internet");
        return [];
      }
      final MovieListResponseModel? response = await apiService
          .getNowPlayingMovies(page);
      if (response == null) return [];
      await movieLocalDataSource.saveNowPlayingMovies(page, response.results);
      return response.results;
    } catch (e, stack) {
      LoggerService().logError(e, stack);
      return [];
    }
  }
}
