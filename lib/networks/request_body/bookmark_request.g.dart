// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookmarkRequest _$BookmarkRequestFromJson(Map<String, dynamic> json) =>
    BookmarkRequest(
      mediaType: json['media_type'] as String,
      mediaId: (json['media_id'] as num).toInt(),
      favorite: json['favorite'] as bool,
    );

Map<String, dynamic> _$BookmarkRequestToJson(BookmarkRequest instance) =>
    <String, dynamic>{
      'media_type': instance.mediaType,
      'media_id': instance.mediaId,
      'favorite': instance.favorite,
    };
