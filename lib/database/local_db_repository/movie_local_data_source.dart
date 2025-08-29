import 'package:movies_db/models/movies/movie_details_model/movie_details_model.dart';
import 'package:movies_db/models/movies/movie_model/movie_model.dart';
import 'package:movies_db/models/trending_movies/trending_movie_model/trending_movie_model.dart';

abstract class MovieLocalDataSource {
  Future<List<TrendingMovieModel>> getTrendingMovies(int page);
  Future<void> saveTrendingMovies(int page, List<TrendingMovieModel> movies);

  Future<List<MovieModel>> getNowPlayingMovies(int page);
  Future<void> saveNowPlayingMovies(int page, List<MovieModel> movies);

  Future<List<MovieModel>> getSearchedMovies(String query, int page);
  Future<void> saveSearchedMovies(
    String query,
    int page,
    List<MovieModel> movies,
  );

  Future<MovieDetailsModel?> getMovieById(int id);
  Future<void> saveMovieById(int id, MovieDetailsModel movie);

  Future<void> saveBookmarkMovieById(int id, [bool isBookmark = true]);
  Set<int> getBookmarkedMovieIds();
  Future<void> saveBookmarkMovieByModel(int page, List<MovieModel> models);
  List<MovieModel> getBookmarkedMovieModels(int page);
}
