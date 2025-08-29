import 'package:json_annotation/json_annotation.dart';

part 'bookmark_request.g.dart';

@JsonSerializable()
class BookmarkRequest {
  @JsonKey(name: 'media_type')
  final String mediaType;

  @JsonKey(name: 'media_id')
  final int mediaId;

  final bool favorite;

  BookmarkRequest({
    required this.mediaType,
    required this.mediaId,
    required this.favorite,
  });

  factory BookmarkRequest.fromJson(Map<String, dynamic> json) =>
      _$BookmarkRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkRequestToJson(this);
}
