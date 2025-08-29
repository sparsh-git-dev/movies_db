import 'package:movies_db/models/movies/movie_model/movie_model.dart';
import 'package:movies_db/models/trending_movies/trending_movie_model/trending_movie_model.dart';

abstract class MovieRepository {
  Future<List<TrendingMovieModel>> getTrendingMovies(int page);
  Future<List<MovieModel>> getNowPlayingMovies(int page);
}
