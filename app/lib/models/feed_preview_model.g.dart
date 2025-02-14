// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedPreviewModelImpl _$$FeedPreviewModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FeedPreviewModelImpl(
      feedTitle: json['feed_title'] as String,
      feedUrl: json['feed_url'] as String,
      articles: (json['articles'] as List<dynamic>)
          .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FeedPreviewModelImplToJson(
        _$FeedPreviewModelImpl instance) =>
    <String, dynamic>{
      'feed_title': instance.feedTitle,
      'feed_url': instance.feedUrl,
      'articles': instance.articles,
    };
