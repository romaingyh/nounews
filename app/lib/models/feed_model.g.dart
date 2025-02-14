// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedModelImpl _$$FeedModelImplFromJson(Map<String, dynamic> json) =>
    _$FeedModelImpl(
      id: (json['feed_id'] as num).toInt(),
      url: json['feed_url'] as String,
      title: json['feed_title'] as String,
      lastFetched: json['last_fetched'] == null
          ? null
          : DateTime.parse(json['last_fetched'] as String),
    );

Map<String, dynamic> _$$FeedModelImplToJson(_$FeedModelImpl instance) =>
    <String, dynamic>{
      'feed_id': instance.id,
      'feed_url': instance.url,
      'feed_title': instance.title,
      'last_fetched': instance.lastFetched?.toIso8601String(),
    };
