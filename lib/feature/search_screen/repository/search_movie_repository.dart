import 'package:movies_db/models/movies/movie_model/movie_model.dart';

abstract class SearchMovieRepository {
  Future<List<MovieModel>> searchByName(String query, int page);
}
