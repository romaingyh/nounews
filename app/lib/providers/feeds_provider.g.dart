// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeds_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$feedsHash() => r'011d1622dcbeddad177b2beeb9873cbdaef68ecf';

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

/// See also [feeds].
@ProviderFor(feeds)
const feedsProvider = FeedsFamily();

/// See also [feeds].
class FeedsFamily extends Family<AsyncValue<List<FeedModel>>> {
  /// See also [feeds].
  const FeedsFamily();

  /// See also [feeds].
  FeedsProvider call({
    String? query,
  }) {
    return FeedsProvider(
      query: query,
    );
  }

  @override
  FeedsProvider getProviderOverride(
    covariant FeedsProvider provider,
  ) {
    return call(
      query: provider.query,
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
  String? get name => r'feedsProvider';
}

/// See also [feeds].
class FeedsProvider extends AutoDisposeFutureProvider<List<FeedModel>> {
  /// See also [feeds].
  FeedsProvider({
    String? query,
  }) : this._internal(
          (ref) => feeds(
            ref as FeedsRef,
            query: query,
          ),
          from: feedsProvider,
          name: r'feedsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$feedsHash,
          dependencies: FeedsFamily._dependencies,
          allTransitiveDependencies: FeedsFamily._allTransitiveDependencies,
          query: query,
        );

  FeedsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String? query;

  @override
  Override overrideWith(
    FutureOr<List<FeedModel>> Function(FeedsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FeedsProvider._internal(
        (ref) => create(ref as FeedsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<FeedModel>> createElement() {
    return _FeedsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FeedsProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FeedsRef on AutoDisposeFutureProviderRef<List<FeedModel>> {
  /// The parameter `query` of this provider.
  String? get query;
}

class _FeedsProviderElement
    extends AutoDisposeFutureProviderElement<List<FeedModel>> with FeedsRef {
  _FeedsProviderElement(super.provider);

  @override
  String? get query => (origin as FeedsProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
