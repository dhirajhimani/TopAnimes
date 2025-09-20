import 'package:json_annotation/json_annotation.dart';
import 'light_novel_model.dart';

part 'light_novel_response.g.dart';

/// Response model for RanobeDB API light novel search endpoint
@JsonSerializable()
class LightNovelResponse {
  /// List of light novel data
  @JsonKey(defaultValue: [])
  final List<LightNovelModel> results;
  
  /// Total count of results
  @JsonKey(defaultValue: 0)
  final int count;

  /// Next page URL
  @JsonKey(defaultValue: '')
  final String next;

  /// Previous page URL
  @JsonKey(defaultValue: '')
  final String previous;

  /// Creates a [LightNovelResponse]
  const LightNovelResponse({
    required this.results,
    required this.count,
    required this.next,
    required this.previous,
  });
  
  /// Creates a [LightNovelResponse] from JSON
  factory LightNovelResponse.fromJson(Map<String, dynamic> json) {
    return LightNovelResponse(
      results: (json['results'] as List<dynamic>?)?.map((e) => LightNovelModel.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      count: json['count'] as int? ?? 0,
      next: json['next'] as String? ?? '',
      previous: json['previous'] as String? ?? '',
    );
  }

  /// Converts this [LightNovelResponse] to JSON
  Map<String, dynamic> toJson() => _$LightNovelResponseToJson(this);
}