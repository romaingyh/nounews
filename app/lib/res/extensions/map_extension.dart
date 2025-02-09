extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> get flattened {
    final map = <K, V>{};

    forEach((key, value) {
      switch (value) {
        case final Map<K, V> nestedMap:
          map.addAll(nestedMap.flattened);
        default:
          map[key] = value;
      }
    });

    return map;
  }
}
