import 'package:json_annotation/json_annotation.dart';

part 'trending_movie_model.g.dart';

@JsonSerializable()
class TrendingMovieModel {
  final bool adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  final int id;
  final String? title;

  @JsonKey(name: 'original_title')
  final String? originalTitle;

  final String? overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'media_type')
  final String? mediaType;

  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;

  final double popularity;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  final bool video;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  @JsonKey(name: 'vote_count')
  final int voteCount;

  TrendingMovieModel({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TrendingMovieModel.fromJson(Map<String, dynamic> json) =>
      _$TrendingMovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$TrendingMovieModelToJson(this);
}
