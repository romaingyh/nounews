import 'package:flutter/foundation.dart';

@immutable
class EquatableListWrapper<T> {
  const EquatableListWrapper(this.list);

  final List<T> list;

  @override
  bool operator ==(covariant EquatableListWrapper<T> other) {
    if (identical(this, other)) return true;

    return listEquals(other.list, list);
  }

  @override
  int get hashCode => list.hashCode;
}
