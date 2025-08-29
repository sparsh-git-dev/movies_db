import 'package:movies_db/feature/bookmark/model/bookmark_response.dart';
import 'package:movies_db/models/movies/movie_details_model/movie_details_model.dart';
import 'package:movies_db/models/movies/movie_list_response_model/movie_list_response_model.dart';
import 'package:movies_db/models/trending_movies/trending_movie_list_response_model/trending_movie_list_response_model.dart';
import 'package:movies_db/networks/endpoint.dart';
import 'package:movies_db/networks/request_body/bookmark_request.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: Endpoints.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("movie/{id}")
  Future<MovieDetailsModel?> getMovie(@Path("id") int movieId);

  @GET("trending/movie/day")
  Future<TrendingMovieListResponseModel?> getTrendingMovies(
    @Query("page") int page,
  );

  @GET("movie/now_playing")
  Future<MovieListResponseModel?> getNowPlayingMovies(@Query("page") int page);

  @GET("/search/movie")
  Future<MovieListResponseModel?> getSearchedMovie(
    @Query("query") String query,
    @Query("page") int? page,
  );

  @POST("/account/{account_id}/favorite")
  Future<BookmarkResponse?> markAsFavorite(
    @Body() BookmarkRequest body, {
    @Path("account_id") int accountId = 22253179,
  });

  @GET("/account/{account_id}/favorite/movies")
  Future<MovieListResponseModel?> getFavoriteMovies({
    @Path("account_id") String accountId = "22253179",
    @Query("language") String language = "en-US",
    @Query("page") int page = 1,
    @Query("sort_by") String sortBy = "created_at.dsc",
  });
}
