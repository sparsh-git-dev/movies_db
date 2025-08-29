import 'package:json_annotation/json_annotation.dart';
import 'package:movies_db/models/movies/movie_model/movie_model.dart';

part 'movie_list_response_model.g.dart';

@JsonSerializable()
class MovieListResponseModel {
  final int page;

  final Dates? dates;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  @JsonKey(name: 'total_results')
  final int totalResults;

  final List<MovieModel> results;

  MovieListResponseModel({
    required this.page,
    required this.dates,
    required this.totalPages,
    required this.totalResults,
    required this.results,
  });

  factory MovieListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MovieListResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieListResponseModelToJson(this);
}

@JsonSerializable()
class Dates {
  final String maximum;
  final String minimum;

  Dates({required this.maximum, required this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);
  Map<String, dynamic> toJson() => _$DatesToJson(this);
}
