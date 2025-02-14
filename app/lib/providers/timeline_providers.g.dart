// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timelineArticlesHash() => r'382532b110b4d1e8a0309af37cacaaf40b639a4d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [timelineArticles].
@ProviderFor(timelineArticles)
const timelineArticlesProvider = TimelineArticlesFamily();

/// See also [timelineArticles].
class TimelineArticlesFamily extends Family<AsyncValue<List<ArticleModel>>> {
  /// See also [timelineArticles].
  const TimelineArticlesFamily();

  /// See also [timelineArticles].
  TimelineArticlesProvider call({
    String? searchQuery,
  }) {
    return TimelineArticlesProvider(
      searchQuery: searchQuery,
    );
  }

  @override
  TimelineArticlesProvider getProviderOverride(
    covariant TimelineArticlesProvider provider,
  ) {
    return call(
      searchQuery: provider.searchQuery,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'timelineArticlesProvider';
}

/// See also [timelineArticles].
class TimelineArticlesProvider
    extends AutoDisposeFutureProvider<List<ArticleModel>> {
  /// See also [timelineArticles].
  TimelineArticlesProvider({
    String? searchQuery,
  }) : this._internal(
          (ref) => timelineArticles(
            ref as TimelineArticlesRef,
            searchQuery: searchQuery,
          ),
          from: timelineArticlesProvider,
          name: r'timelineArticlesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$timelineArticlesHash,
          dependencies: TimelineArticlesFamily._dependencies,
          allTransitiveDependencies:
              TimelineArticlesFamily._allTransitiveDependencies,
          searchQuery: searchQuery,
        );

  TimelineArticlesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.searchQuery,
  }) : super.internal();

  final String? searchQuery;

  @override
  Override overrideWith(
    FutureOr<List<ArticleModel>> Function(TimelineArticlesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TimelineArticlesProvider._internal(
        (ref) => create(ref as TimelineArticlesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        searchQuery: searchQuery,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ArticleModel>> createElement() {
    return _TimelineArticlesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TimelineArticlesProvider &&
        other.searchQuery == searchQuery;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchQuery.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TimelineArticlesRef on AutoDisposeFutureProviderRef<List<ArticleModel>> {
  /// The parameter `searchQuery` of this provider.
  String? get searchQuery;
}

class _TimelineArticlesProviderElement
    extends AutoDisposeFutureProviderElement<List<ArticleModel>>
    with TimelineArticlesRef {
  _TimelineArticlesProviderElement(super.provider);

  @override
  String? get searchQuery => (origin as TimelineArticlesProvider).searchQuery;
}

String _$isFeedHiddenHash() => r'b7133c80616f3e8baef1d883d0f2304466a31c16';

/// See also [isFeedHidden].
@ProviderFor(isFeedHidden)
const isFeedHiddenProvider = IsFeedHiddenFamily();

/// See also [isFeedHidden].
class IsFeedHiddenFamily extends Family<bool> {
  /// See also [isFeedHidden].
  const IsFeedHiddenFamily();

  /// See also [isFeedHidden].
  IsFeedHiddenProvider call(
    FeedModel feed,
  ) {
    return IsFeedHiddenProvider(
      feed,
    );
  }

  @override
  IsFeedHiddenProvider getProviderOverride(
    covariant IsFeedHiddenProvider provider,
  ) {
    return call(
      provider.feed,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isFeedHiddenProvider';
}

/// See also [isFeedHidden].
class IsFeedHiddenProvider extends AutoDisposeProvider<bool> {
  /// See also [isFeedHidden].
  IsFeedHiddenProvider(
    FeedModel feed,
  ) : this._internal(
          (ref) => isFeedHidden(
            ref as IsFeedHiddenRef,
            feed,
          ),
          from: isFeedHiddenProvider,
          name: r'isFeedHiddenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isFeedHiddenHash,
          dependencies: IsFeedHiddenFamily._dependencies,
          allTransitiveDependencies:
              IsFeedHiddenFamily._allTransitiveDependencies,
          feed: feed,
        );

  IsFeedHiddenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.feed,
  }) : super.internal();

  final FeedModel feed;

  @override
  Override overrideWith(
    bool Function(IsFeedHiddenRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsFeedHiddenProvider._internal(
        (ref) => create(ref as IsFeedHiddenRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        feed: feed,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsFeedHiddenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsFeedHiddenProvider && other.feed == feed;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, feed.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsFeedHiddenRef on AutoDisposeProviderRef<bool> {
  /// The parameter `feed` of this provider.
  FeedModel get feed;
}

class _IsFeedHiddenProviderElement extends AutoDisposeProviderElement<bool>
    with IsFeedHiddenRef {
  _IsFeedHiddenProviderElement(super.provider);

  @override
  FeedModel get feed => (origin as IsFeedHiddenProvider).feed;
}

String _$timelineHiddenFeedsHash() =>
    r'bff1898ee9689b62d1cccf5b57378398bc6e1ed2';

/// See also [TimelineHiddenFeeds].
@ProviderFor(TimelineHiddenFeeds)
final timelineHiddenFeedsProvider =
    AutoDisposeNotifierProvider<TimelineHiddenFeeds, List<int>>.internal(
  TimelineHiddenFeeds.new,
  name: r'timelineHiddenFeedsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$timelineHiddenFeedsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TimelineHiddenFeeds = AutoDisposeNotifier<List<int>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
