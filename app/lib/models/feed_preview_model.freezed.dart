// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_preview_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FeedPreviewModel _$FeedPreviewModelFromJson(Map<String, dynamic> json) {
  return _FeedPreviewModel.fromJson(json);
}

/// @nodoc
mixin _$FeedPreviewModel {
  String? get feedTitle => throw _privateConstructorUsedError;
  List<ArticleModel> get articles => throw _privateConstructorUsedError;

  /// Serializes this FeedPreviewModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeedPreviewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedPreviewModelCopyWith<FeedPreviewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedPreviewModelCopyWith<$Res> {
  factory $FeedPreviewModelCopyWith(
          FeedPreviewModel value, $Res Function(FeedPreviewModel) then) =
      _$FeedPreviewModelCopyWithImpl<$Res, FeedPreviewModel>;
  @useResult
  $Res call({String? feedTitle, List<ArticleModel> articles});
}

/// @nodoc
class _$FeedPreviewModelCopyWithImpl<$Res, $Val extends FeedPreviewModel>
    implements $FeedPreviewModelCopyWith<$Res> {
  _$FeedPreviewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedPreviewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? feedTitle = freezed,
    Object? articles = null,
  }) {
    return _then(_value.copyWith(
      feedTitle: freezed == feedTitle
          ? _value.feedTitle
          : feedTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      articles: null == articles
          ? _value.articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<ArticleModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedPreviewModelImplCopyWith<$Res>
    implements $FeedPreviewModelCopyWith<$Res> {
  factory _$$FeedPreviewModelImplCopyWith(_$FeedPreviewModelImpl value,
          $Res Function(_$FeedPreviewModelImpl) then) =
      __$$FeedPreviewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? feedTitle, List<ArticleModel> articles});
}

/// @nodoc
class __$$FeedPreviewModelImplCopyWithImpl<$Res>
    extends _$FeedPreviewModelCopyWithImpl<$Res, _$FeedPreviewModelImpl>
    implements _$$FeedPreviewModelImplCopyWith<$Res> {
  __$$FeedPreviewModelImplCopyWithImpl(_$FeedPreviewModelImpl _value,
      $Res Function(_$FeedPreviewModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeedPreviewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? feedTitle = freezed,
    Object? articles = null,
  }) {
    return _then(_$FeedPreviewModelImpl(
      feedTitle: freezed == feedTitle
          ? _value.feedTitle
          : feedTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      articles: null == articles
          ? _value._articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<ArticleModel>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$FeedPreviewModelImpl implements _FeedPreviewModel {
  _$FeedPreviewModelImpl(
      {required this.feedTitle, required final List<ArticleModel> articles})
      : _articles = articles;

  factory _$FeedPreviewModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedPreviewModelImplFromJson(json);

  @override
  final String? feedTitle;
  final List<ArticleModel> _articles;
  @override
  List<ArticleModel> get articles {
    if (_articles is EqualUnmodifiableListView) return _articles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_articles);
  }

  @override
  String toString() {
    return 'FeedPreviewModel(feedTitle: $feedTitle, articles: $articles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedPreviewModelImpl &&
            (identical(other.feedTitle, feedTitle) ||
                other.feedTitle == feedTitle) &&
            const DeepCollectionEquality().equals(other._articles, _articles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, feedTitle, const DeepCollectionEquality().hash(_articles));

  /// Create a copy of FeedPreviewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedPreviewModelImplCopyWith<_$FeedPreviewModelImpl> get copyWith =>
      __$$FeedPreviewModelImplCopyWithImpl<_$FeedPreviewModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedPreviewModelImplToJson(
      this,
    );
  }
}

abstract class _FeedPreviewModel implements FeedPreviewModel {
  factory _FeedPreviewModel(
      {required final String? feedTitle,
      required final List<ArticleModel> articles}) = _$FeedPreviewModelImpl;

  factory _FeedPreviewModel.fromJson(Map<String, dynamic> json) =
      _$FeedPreviewModelImpl.fromJson;

  @override
  String? get feedTitle;
  @override
  List<ArticleModel> get articles;

  /// Create a copy of FeedPreviewModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedPreviewModelImplCopyWith<_$FeedPreviewModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
