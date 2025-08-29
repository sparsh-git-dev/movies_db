import 'package:json_annotation/json_annotation.dart';

part 'bookmark_response.g.dart';

@JsonSerializable()
class BookmarkResponse {
  final bool success;

  @JsonKey(name: 'status_code')
  final int statusCode;

  @JsonKey(name: 'status_message')
  final String statusMessage;

  BookmarkResponse({
    required this.success,
    required this.statusCode,
    required this.statusMessage,
  });

  factory BookmarkResponse.fromJson(Map<String, dynamic> json) =>
      _$BookmarkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkResponseToJson(this);
}
