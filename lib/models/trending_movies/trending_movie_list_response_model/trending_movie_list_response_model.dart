import 'package:json_annotation/json_annotation.dart';
import 'package:movies_db/models/trending_movies/trending_movie_model/trending_movie_model.dart';

part 'trending_movie_list_response_model.g.dart';

@JsonSerializable()
class TrendingMovieListResponseModel {
  final int page;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  @JsonKey(name: 'total_results')
  final int totalResults;

  final List<TrendingMovieModel> results;

  TrendingMovieListResponseModel({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.results,
  });

  factory TrendingMovieListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TrendingMovieListResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$TrendingMovieListResponseModelToJson(this);
}
