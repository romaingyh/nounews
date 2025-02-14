import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_model.freezed.dart';
part 'article_model.g.dart';

@Freezed()
class ArticleModel with _$ArticleModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ArticleModel({
    @JsonKey(name: 'article_id') required int? id,
    required int? feedId,
    required String? feedTitle,
    required String referenceUrl,
    required String title,
    String? description,
    String? thumbnailUrl,
    DateTime? publishedAt,
  }) = _ArticleModel;

  factory ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);
}
