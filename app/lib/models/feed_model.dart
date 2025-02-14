import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_model.freezed.dart';
part 'feed_model.g.dart';

@freezed
class FeedModel with _$FeedModel {
  const factory FeedModel({
    @JsonKey(name: 'feed_id') required int id,
    @JsonKey(name: 'feed_url') required String url,
    @JsonKey(name: 'feed_title') required String title,
    @JsonKey(name: 'last_fetched') required DateTime? lastFetched,
  }) = _FeedModel;

  factory FeedModel.fromJson(Map<String, dynamic> json) => _$FeedModelFromJson(json);
}
