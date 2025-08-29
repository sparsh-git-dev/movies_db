import 'package:get/get.dart';
import 'package:movies_db/database/local_db_repository/movie_local_data_source_impl.dart';
import 'package:movies_db/feature/movie_details/repository/movie_details_repository_impl.dart';
import 'package:movies_db/feature/movie_details/view_model/movie_details_view_model.dart';
import 'package:movies_db/models/movies/movie_details_model/movie_details_model.dart';

class MovieDetailViewController extends GetxController {
  int id;
  MovieDetailViewController(this.id);

  MovieDetailsModel? movieDetailViewModel;
  late final MovieDetailsViewModel movieDetailsViewModel;
  bool isLoading = true;
  void handleDisposal() {
    movieDetailViewModel = null;
    isLoading = true;
  }

  @override
  void onInit() {
    intialiseDependencies();
    super.onInit();
  }

  Future<void> intialiseDependencies() async {
    movieDetailsViewModel = MovieDetailsViewModel(
      MovieDetailsRepositoryImpl(MovieLocalDataSourceImp()),
    );
    movieDetailViewModel = await movieDetailsViewModel.getMovieDetailsById(id);
    isLoading = false;
    update();
  }

  Future<void> retry() async {
    isLoading = true;
    update();
    movieDetailViewModel = await movieDetailsViewModel.getMovieDetailsById(id);
    isLoading = false;
    update();
  }
}
