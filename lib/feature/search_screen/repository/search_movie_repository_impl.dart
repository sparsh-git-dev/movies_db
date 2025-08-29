import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:movies_db/database/local_db_repository/movie_local_data_source.dart';
import 'package:movies_db/feature/search_screen/repository/search_movie_repository.dart';
import 'package:movies_db/models/movies/movie_list_response_model/movie_list_response_model.dart';
import 'package:movies_db/models/movies/movie_model/movie_model.dart';
import 'package:movies_db/service/logger_service.dart';
import 'package:movies_db/service_locator.dart';

class SearchMovieRepositoryImpl implements SearchMovieRepository {
  final MovieLocalDataSource movieLocalDataSource;
  SearchMovieRepositoryImpl(this.movieLocalDataSource);
  @override
  Future<List<MovieModel>> searchByName(String query, int page) async {
    try {
      List<MovieModel> localMovies = await movieLocalDataSource
          .getSearchedMovies(query, page);
      if (localMovies.isNotEmpty) return localMovies;
      bool internetAccess = await InternetConnection().hasInternetAccess;
      if (!internetAccess) {
        LoggerService().logError("No internet");
        return [];
      }
      final MovieListResponseModel? response = await apiService
          .getSearchedMovie(query, page);
      if (response == null) return [];
      await movieLocalDataSource.saveSearchedMovies(
        query,
        page,
        response.results,
      );
      return response.results;
    } catch (e, stack) {
      LoggerService().logError(e, stack);
      return [];
    }
  }
}
