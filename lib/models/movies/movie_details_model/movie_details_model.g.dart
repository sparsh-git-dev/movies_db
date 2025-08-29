// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsModel _$MovieDetailsModelFromJson(
  Map<String, dynamic> json,
) => MovieDetailsModel(
  adult: json['adult'] as bool? ?? false,
  backdropPath: json['backdrop_path'] as String?,
  budget: (json['budget'] as num?)?.toInt(),
  genres:
      (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  homepage: json['homepage'] as String?,
  id: (json['id'] as num?)?.toInt() ?? 0,
  imdbId: json['imdb_id'] as String?,
  originCountry:
      (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  originalLanguage: json['original_language'] as String?,
  originalTitle: json['original_title'] as String?,
  overview: json['overview'] as String?,
  popularity: (json['popularity'] as num?)?.toDouble(),
  posterPath: json['poster_path'] as String?,
  productionCompanies:
      (json['production_companies'] as List<dynamic>?)
          ?.map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  productionCountries:
      (json['production_countries'] as List<dynamic>?)
          ?.map((e) => ProductionCountry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  releaseDate: json['release_date'] as String?,
  revenue: (json['revenue'] as num?)?.toInt(),
  runtime: (json['runtime'] as num?)?.toInt(),
  spokenLanguages:
      (json['spoken_languages'] as List<dynamic>?)
          ?.map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  status: json['status'] as String?,
  tagline: json['tagline'] as String?,
  title: json['title'] as String?,
  video: json['video'] as bool? ?? false,
  voteAverage: (json['vote_average'] as num?)?.toDouble(),
  voteCount: (json['vote_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$MovieDetailsModelToJson(MovieDetailsModel instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'budget': instance.budget,
      'genres': instance.genres,
      'homepage': instance.homepage,
      'id': instance.id,
      'imdb_id': instance.imdbId,
      'origin_country': instance.originCountry,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'production_companies': instance.productionCompanies,
      'production_countries': instance.productionCountries,
      'release_date': instance.releaseDate,
      'revenue': instance.revenue,
      'runtime': instance.runtime,
      'spoken_languages': instance.spokenLanguages,
      'status': instance.status,
      'tagline': instance.tagline,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };

Genre _$GenreFromJson(Map<String, dynamic> json) =>
    Genre(id: (json['id'] as num).toInt(), name: json['name'] as String?);

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

ProductionCompany _$ProductionCompanyFromJson(Map<String, dynamic> json) =>
    ProductionCompany(
      id: (json['id'] as num).toInt(),
      logoPath: json['logoPath'] as String?,
      name: json['name'] as String?,
      originCountry: json['origin_country'] as String?,
    );

Map<String, dynamic> _$ProductionCompanyToJson(ProductionCompany instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logoPath': instance.logoPath,
      'name': instance.name,
      'origin_country': instance.originCountry,
    };

ProductionCountry _$ProductionCountryFromJson(Map<String, dynamic> json) =>
    ProductionCountry(
      iso3166_1: json['iso_3166_1'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ProductionCountryToJson(ProductionCountry instance) =>
    <String, dynamic>{'iso_3166_1': instance.iso3166_1, 'name': instance.name};

SpokenLanguage _$SpokenLanguageFromJson(Map<String, dynamic> json) =>
    SpokenLanguage(
      englishName: json['english_name'] as String?,
      iso639_1: json['iso_639_1'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SpokenLanguageToJson(SpokenLanguage instance) =>
    <String, dynamic>{
      'english_name': instance.englishName,
      'iso_639_1': instance.iso639_1,
      'name': instance.name,
    };
