import 'package:movies_db/models/movies/movie_model/movie_model.dart';
import 'package:movies_db/models/trending_movies/trending_movie_model/trending_movie_model.dart';
import 'package:movies_db/feature/home_screen/repository/movies_repository.dart';

class MovieViewModel {
  final MovieRepository movieRepository;

  MovieViewModel({required this.movieRepository});

  Future<List<TrendingMovieModel>> fetchTrendingMovies(int page) async =>
      await movieRepository.getTrendingMovies(page);
  Future<List<MovieModel>> fetchNowPlayingMovies(int page) async =>
      await movieRepository.getNowPlayingMovies(page);
}
