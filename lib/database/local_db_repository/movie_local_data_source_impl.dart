import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:movies_db/database/local_db_repository/storage_keys.dart';
import 'package:movies_db/models/movies/movie_details_model/movie_details_model.dart';
import 'package:movies_db/models/movies/movie_model/movie_model.dart';
import 'package:movies_db/models/trending_movies/trending_movie_model/trending_movie_model.dart';
import 'package:movies_db/database/local_db_repository/movie_local_data_source.dart';

class MovieLocalDataSourceImp implements MovieLocalDataSource {
  @override
  Future<List<TrendingMovieModel>> getTrendingMovies(int page) async {
    String data =
        GetStorage().read("${StorageKeys.trendingMovies}_$page") ?? '';
    if (data.isEmpty) return [];
    final resp = jsonDecode(data);
    return (resp as List).map((e) => TrendingMovieModel.fromJson(e)).toList();
  }

  @override
  Future<void> saveTrendingMovies(
    int page,
    List<TrendingMovieModel> movies,
  ) async {
    GetStorage().write(
      "${StorageKeys.trendingMovies}_$page",
      jsonEncode(movies.map((e) => e.toJson()).toList()),
    );
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies(int page) async {
    String data =
        GetStorage().read("${StorageKeys.nowPlayingMovies}_$page") ?? '';
    if (data.isEmpty) return [];
    final resp = jsonDecode(data);
    return (resp as List).map((e) => MovieModel.fromJson(e)).toList();
  }

  @override
  Future<void> saveNowPlayingMovies(int page, List<MovieModel> movies) async {
    GetStorage().write(
      "${StorageKeys.nowPlayingMovies}_$page",
      jsonEncode(movies.map((e) => e.toJson()).toList()),
    );
  }

  @override
  Future<MovieDetailsModel?> getMovieById(int id) async {
    String data = GetStorage().read("${StorageKeys.movieById}_$id") ?? '';
    if (data.isEmpty) return Future.value(null);
    final resp = jsonDecode(data);
    return MovieDetailsModel.fromJson(resp);
  }

  @override
  Future<void> saveMovieById(int id, MovieDetailsModel movie) async {
    GetStorage().write(
      "${StorageKeys.movieById}_$id",
      jsonEncode(movie.toJson()),
    );
  }

  @override
  Future<List<MovieModel>> getSearchedMovies(String query, int page) async {
    String data =
        GetStorage().read("${StorageKeys.movieBySearch}_${page}_$query") ?? '';
    if (data.isEmpty) return [];
    final resp = jsonDecode(data);
    return (resp as List).map((e) => MovieModel.fromJson(e)).toList();
  }

  @override
  Future<void> saveSearchedMovies(
    String query,
    int page,
    List<MovieModel> movies,
  ) async {
    GetStorage().write(
      "${StorageKeys.movieBySearch}_${page}_$query",
      jsonEncode(movies.map((e) => e.toJson()).toList()),
    );
  }

  @override
  Future<void> saveBookmarkMovieById(int id, [bool isBookmark = true]) async {
    Set<int> allBookmarks = getBookmarkedMovieIds();
    if (isBookmark) {
      allBookmarks.add(id);
    } else {
      allBookmarks.remove(id);
    }
    GetStorage().write(
      StorageKeys.bookmarkByIDs,
      jsonEncode(allBookmarks.toList()),
    );
  }

  @override
  Set<int> getBookmarkedMovieIds() {
    String data = GetStorage().read(StorageKeys.bookmarkByIDs) ?? '';
    if (data.isEmpty) return {};
    return (jsonDecode(data) as List<dynamic>).map((e) => e as int).toSet();
  }

  @override
  Future<void> saveBookmarkMovieByModel(
    int page,
    List<MovieModel> models,
  ) async {
    GetStorage().write(
      "${StorageKeys.bookmarkByModelPage}_$page",
      jsonEncode(models.map((e) => e.toJson()).toList()),
    );
  }

  @override
  List<MovieModel> getBookmarkedMovieModels(int page) {
    String data =
        GetStorage().read("${StorageKeys.bookmarkByModelPage}_$page") ?? '';
    if (data.isEmpty) return [];
    final resp = jsonDecode(data);
    return (resp as List).map((e) => MovieModel.fromJson(e)).toList();
  }
}
