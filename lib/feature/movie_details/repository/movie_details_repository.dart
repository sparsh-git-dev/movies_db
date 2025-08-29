import 'package:movies_db/feature/movie_details/view_model/movie_details_view_model.dart';
import 'package:movies_db/models/movies/movie_details_model/movie_details_model.dart';

abstract class MovieDetailsRepository {
  Future<MovieDetailsModel?> getMovieDetails(int id);
}
