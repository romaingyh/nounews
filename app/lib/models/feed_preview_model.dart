import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nounews_app/models/article_model.dart';

part 'feed_preview_model.freezed.dart';
part 'feed_preview_model.g.dart';

@freezed
class FeedPreviewModel with _$FeedPreviewModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory FeedPreviewModel({
    required String? feedTitle,
    required List<ArticleModel> articles,
  }) = _FeedPreviewModel;

  factory FeedPreviewModel.fromJson(Map<String, dynamic> json) => _$FeedPreviewModelFromJson(json);
}
