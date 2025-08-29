import 'package:movies_db/feature/bookmark/model/bookmark_response.dart';
import 'package:movies_db/models/movies/movie_model/movie_model.dart';
import 'package:movies_db/networks/request_body/bookmark_request.dart';

abstract class BookmarkRepository {
  Future<List<MovieModel>> getAllBookmarks(int page);
  Future<BookmarkResponse?> postBookmark(BookmarkRequest req);
}
