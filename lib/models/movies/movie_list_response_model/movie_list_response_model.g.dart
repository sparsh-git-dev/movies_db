// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieListResponseModel _$MovieListResponseModelFromJson(
  Map<String, dynamic> json,
) => MovieListResponseModel(
  page: (json['page'] as num).toInt(),
  dates: json['dates'] == null
      ? null
      : Dates.fromJson(json['dates'] as Map<String, dynamic>),
  totalPages: (json['total_pages'] as num).toInt(),
  totalResults: (json['total_results'] as num).toInt(),
  results: (json['results'] as List<dynamic>)
      .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MovieListResponseModelToJson(
  MovieListResponseModel instance,
) => <String, dynamic>{
  'page': instance.page,
  'dates': instance.dates,
  'total_pages': instance.totalPages,
  'total_results': instance.totalResults,
  'results': instance.results,
};

Dates _$DatesFromJson(Map<String, dynamic> json) => Dates(
  maximum: json['maximum'] as String,
  minimum: json['minimum'] as String,
);

Map<String, dynamic> _$DatesToJson(Dates instance) => <String, dynamic>{
  'maximum': instance.maximum,
  'minimum': instance.minimum,
};
