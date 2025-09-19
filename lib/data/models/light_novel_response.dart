import 'package:json_annotation/json_annotation.dart';
import 'light_novel_model.dart';

part 'light_novel_response.g.dart';

/// Response model for RanobeDB API light novel search endpoint
@JsonSerializable()
class LightNovelResponse {
  /// List of light novel data
  final List<LightNovelModel> results;
  
  /// Total count of results
  final int? count;
  
  /// Next page URL
  final String? next;
  
  /// Previous page URL
  final String? previous;
  
  /// Creates a [LightNovelResponse]
  const LightNovelResponse({
    required this.results,
    this.count,
    this.next,
    this.previous,
  });
  
  /// Creates a [LightNovelResponse] from JSON
  factory LightNovelResponse.fromJson(Map<String, dynamic> json) => 
      _$LightNovelResponseFromJson(json);
  
  /// Converts this [LightNovelResponse] to JSON
  Map<String, dynamic> toJson() => _$LightNovelResponseToJson(this);
}