import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:movies_db/database/local_db_repository/movie_local_data_source.dart';
import 'package:movies_db/feature/movie_details/repository/movie_details_repository.dart';
import 'package:movies_db/models/movies/movie_details_model/movie_details_model.dart';
import 'package:movies_db/service/logger_service.dart';
import 'package:movies_db/service_locator.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieLocalDataSource movieLocalDataSource;
  MovieDetailsRepositoryImpl(this.movieLocalDataSource);
  @override
  Future<MovieDetailsModel?> getMovieDetails(int id) async {
    try {
      MovieDetailsModel? localMovie = await movieLocalDataSource.getMovieById(
        id,
      );
      if (localMovie != null) return localMovie;
      bool internetAccess = await InternetConnection().hasInternetAccess;
      if (!internetAccess) {
        LoggerService().logError("No internet");
        return null;
      }
      final MovieDetailsModel? movie = await apiService.getMovie(id);
      if (movie == null) return null;
      await movieLocalDataSource.saveMovieById(id, movie);
      return movie;
    } catch (e, stack) {
      LoggerService().logError(e, stack);
      return null;
    }
  }
}
