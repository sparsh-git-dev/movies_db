import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies_db/core/widget/toast.dart';
import 'package:movies_db/database/local_db_repository/movie_local_data_source_impl.dart';
import 'package:movies_db/feature/bookmark/model/bookmark_response.dart';
import 'package:movies_db/feature/bookmark/repository/bookmark_repository_impl.dart';
import 'package:movies_db/models/movies/movie_model/movie_model.dart';
import 'package:movies_db/networks/request_body/bookmark_request.dart';
import 'package:movies_db/service/logger_service.dart';

class BookmarkController extends GetxController {
  static BookmarkController get to => Get.find<BookmarkController>();
  final BookmarkRepositoryImpl repo = BookmarkRepositoryImpl(
    movieLocalDataSource: MovieLocalDataSourceImp(),
  );

  bool isBookmarked(int id) {
    Set<int> allBookmarked = MovieLocalDataSourceImp().getBookmarkedMovieIds();
    return allBookmarked.contains(id);
  }

  List<MovieModel> allbookmarks = [];

  PagingController<int, MovieModel> bookmarkPaging =
      PagingController<int, MovieModel>(firstPageKey: 1);

  void intialiseDependency() {
    bookmarkPaging = PagingController<int, MovieModel>(firstPageKey: 1);
    bookmarkPaging.addPageRequestListener((v) => fetchAllBookMarksToPaging(v));
  }

  void handleDisposal() {
    bookmarkPaging.dispose();
  }

  @override
  void onInit() {
    fetchAllBookMarks();
    super.onInit();
  }

  Future<void> refreshpage() async {
    bookmarkPaging.refresh();
  }

  Future<void> fetchAllBookMarks([int page = 1]) async {
    await repo.getAllBookmarks(page);
  }

  Future<void> fetchAllBookMarksToPaging([int page = 1]) async {
    try {
      final movies = await repo.getAllBookmarks(page);

      final isLastPage = movies.isEmpty;
      if (isLastPage) {
        bookmarkPaging.appendLastPage(movies);
      } else {
        bookmarkPaging.appendPage(movies, page + 1);
      }
    } catch (error, stack) {
      LoggerService().logError(error, stack);
      bookmarkPaging.error = error;
    }
  }

  Future<void> bookmarkById(int id) async {
    bool initalBookmarkState = isBookmarked(id);
    BookmarkRequest req = BookmarkRequest(
      mediaType: "movie",
      mediaId: id,
      favorite: !initalBookmarkState,
    );
    BookmarkResponse? resp = await repo.postBookmark(req);
    if (resp == null) {
      showSnackBar("Something went wrong", snackType: SnackType.error);
    } else if (initalBookmarkState && resp.success) {
      showSnackBar("Successfully unbookmarked", snackType: SnackType.success);
    } else if (!initalBookmarkState && resp.success) {
      showSnackBar("Successfully bookmarked", snackType: SnackType.success);
    }
    update();
  }

  void bookMarkByModel(MovieModel model) {}
}
