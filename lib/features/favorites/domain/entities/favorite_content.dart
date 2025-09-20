import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import '../../../domain/entities/content.dart';

/// Entity representing a favorite content item
class FavoriteContent extends Equatable with HiveObjectMixin {
  /// Unique identifier
  @HiveField(0)
  final int id;
  
  /// Content title
  @HiveField(1)
  final String title;
  
  /// Content type (anime, manga, light novel)
  @HiveField(2)
  final String type;
  
  /// Image URL
  @HiveField(3)
  final String imageUrl;
  
  /// Content URL
  @HiveField(4)
  final String url;
  
  /// Score/rating
  @HiveField(5)
  final double? score;
  
  /// When it was added to favorites
  @HiveField(6)
  final DateTime addedAt;
  
  /// Creates a [FavoriteContent]
  const FavoriteContent({
    required this.id,
    required this.title,
    required this.type,
    required this.imageUrl,
    required this.url,
    this.score,
    required this.addedAt,
  });
  
  /// Creates a [FavoriteContent] from a [Content] entity
  factory FavoriteContent.fromContent(Content content) {
    return FavoriteContent(
      id: content.id,
      title: content.title,
      type: content.type.name,
      imageUrl: content.imageUrl,
      url: content.url,
      score: content.score,
      addedAt: DateTime.now(),
    );
  }
  
  /// Converts to [Content] entity
  Content toContent() {
    return Content(
      id: id,
      title: title,
      type: ContentType.values.firstWhere(
        (t) => t.name == type,
        orElse: () => ContentType.anime,
      ),
      imageUrl: imageUrl,
      url: url,
      score: score,
      synopsis: '',
      metadata: {},
    );
  }
  
  @override
  List<Object?> get props => [
    id,
    title,
    type,
    imageUrl,
    url,
    score,
    addedAt,
  ];
}

/// Hive adapter for FavoriteContent
class FavoriteContentAdapter extends TypeAdapter<FavoriteContent> {
  @override
  final int typeId = 0;

  @override
  FavoriteContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteContent(
      id: fields[0] as int,
      title: fields[1] as String,
      type: fields[2] as String,
      imageUrl: fields[3] as String,
      url: fields[4] as String,
      score: fields[5] as double?,
      addedAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteContent obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.score)
      ..writeByte(6)
      ..write(obj.addedAt);
  }

  @override
  bool get isAdaptedType => true;
}