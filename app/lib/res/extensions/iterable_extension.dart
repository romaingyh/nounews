extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  Iterable<E> mapEmptySafe<E>(E Function(T e) toElement) {
    if (isEmpty) return [];
    return map(toElement);
  }

  Iterable<T> replaceWhere(bool Function(T element) test, T replace) {
    return map((element) => test(element) ? replace : element);
  }

  Map<K, List<T>> groupBy<K>(
    K Function(T element) keySelector, {
    int Function(T a, T b)? itemsSorter,
  }) {
    final map = <K, List<T>>{};

    for (final element in this) {
      final key = keySelector(element);
      if (!map.containsKey(key)) {
        map[key] = [];
      }
      map[key]!.add(element);
    }

    if (itemsSorter != null) {
      for (final key in map.keys) {
        map[key]!.sort(itemsSorter);
      }
    }

    return map;
  }
}
