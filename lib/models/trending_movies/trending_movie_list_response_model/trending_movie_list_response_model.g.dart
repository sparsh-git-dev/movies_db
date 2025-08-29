// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_movie_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingMovieListResponseModel _$TrendingMovieListResponseModelFromJson(
  Map<String, dynamic> json,
) => TrendingMovieListResponseModel(
  page: (json['page'] as num).toInt(),
  totalPages: (json['total_pages'] as num).toInt(),
  totalResults: (json['total_results'] as num).toInt(),
  results: (json['results'] as List<dynamic>)
      .map((e) => TrendingMovieModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TrendingMovieListResponseModelToJson(
  TrendingMovieListResponseModel instance,
) => <String, dynamic>{
  'page': instance.page,
  'total_pages': instance.totalPages,
  'total_results': instance.totalResults,
  'results': instance.results,
};
