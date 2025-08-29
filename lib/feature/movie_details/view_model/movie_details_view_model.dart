import 'package:movies_db/feature/movie_details/repository/movie_details_repository.dart';
import 'package:movies_db/models/movies/movie_details_model/movie_details_model.dart';

class MovieDetailsViewModel {
  final MovieDetailsRepository movieRepo;
  MovieDetailsViewModel(this.movieRepo);

  Future<MovieDetailsModel?> getMovieDetailsById(int id) async =>
      movieRepo.getMovieDetails(id);
}
