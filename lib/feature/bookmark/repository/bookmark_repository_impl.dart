import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:movies_db/database/local_db_repository/movie_local_data_source.dart';
import 'package:movies_db/feature/bookmark/model/bookmark_response.dart';
import 'package:movies_db/feature/bookmark/repository/bookmark_repository.dart';
import 'package:movies_db/models/movies/movie_list_response_model/movie_list_response_model.dart';
import 'package:movies_db/models/movies/movie_model/movie_model.dart';
import 'package:movies_db/service/logger_service.dart';
import 'package:movies_db/service_locator.dart';

import '../../../networks/request_body/bookmark_request.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final MovieLocalDataSource movieLocalDataSource;
  const BookmarkRepositoryImpl({required this.movieLocalDataSource});
  @override
  Future<List<MovieModel>> getAllBookmarks(int page) async {
    try {
      bool internetAccess = await InternetConnection().hasInternetAccess;
      if (!internetAccess) {
        LoggerService().logError("No internet");
        List<MovieModel> localMovies = movieLocalDataSource
            .getBookmarkedMovieModels(page);
        return localMovies;
      }
      final MovieListResponseModel? response = await apiService
          .getFavoriteMovies(page: page);
      if (response == null) return [];
      await movieLocalDataSource.saveBookmarkMovieByModel(
        page,
        response.results,
      );
      List<int> ids = response.results.map((e) => e.id).toList();
      for (int id in ids) {
        await movieLocalDataSource.saveBookmarkMovieById(id);
      }
      return response.results;
    } catch (e, stack) {
      LoggerService().logError(e, stack);
      return [];
    }
  }

  @override
  Future<BookmarkResponse?> postBookmark(BookmarkRequest req) async {
    try {
      bool internetAccess = await InternetConnection().hasInternetAccess;
      if (!internetAccess) {
        LoggerService().logError("No internet");
        return null;
      }

      BookmarkResponse? resp = await apiService.markAsFavorite(req);
      if (resp != null && resp.success) {
        await movieLocalDataSource.saveBookmarkMovieById(
          req.mediaId,
          req.favorite,
        );
        return resp;
      }

      return null;
    } catch (e, stack) {
      LoggerService().logError(e, stack);
      return null;
    }
  }
}
