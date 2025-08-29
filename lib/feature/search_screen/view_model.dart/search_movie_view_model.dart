import 'package:movies_db/feature/search_screen/repository/search_movie_repository.dart';
import 'package:movies_db/models/movies/movie_model/movie_model.dart';

class SearchMovieViewModel {
  final SearchMovieRepository searchMovieRepository;

  SearchMovieViewModel({required this.searchMovieRepository});

  Future<List<MovieModel>> fetchSearchedMovies(String query, int page) async =>
      await searchMovieRepository.searchByName(query, page);
}
