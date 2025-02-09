// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticleModelImpl _$$ArticleModelImplFromJson(Map<String, dynamic> json) =>
    _$ArticleModelImpl(
      id: (json['article_id'] as num?)?.toInt(),
      feedId: (json['feed_id'] as num?)?.toInt(),
      feedName: json['feed_name'] as String?,
      referenceUrl: json['reference_url'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      thumbnailUrl: json['thumbnail_url'] as String?,
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
    );

Map<String, dynamic> _$$ArticleModelImplToJson(_$ArticleModelImpl instance) =>
    <String, dynamic>{
      'article_id': instance.id,
      'feed_id': instance.feedId,
      'feed_name': instance.feedName,
      'reference_url': instance.referenceUrl,
      'title': instance.title,
      'description': instance.description,
      'thumbnail_url': instance.thumbnailUrl,
      'published_at': instance.publishedAt?.toIso8601String(),
    };
