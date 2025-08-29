// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookmarkResponse _$BookmarkResponseFromJson(Map<String, dynamic> json) =>
    BookmarkResponse(
      success: json['success'] as bool,
      statusCode: (json['status_code'] as num).toInt(),
      statusMessage: json['status_message'] as String,
    );

Map<String, dynamic> _$BookmarkResponseToJson(BookmarkResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'status_message': instance.statusMessage,
    };
