import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

extension RefX on Ref {
  KeepAliveLink cacheFor([Duration duration = const Duration(seconds: 30)]) {
    Timer? timer;
    // prevents being disposed
    final link = keepAlive();

    // when the provider is no longer used (removed all listeners)
    // the timer will be started with the given cache duration
    // when the time expires, the link will be closed,
    // and the provider will dispose itself
    onCancel(() => timer = Timer(duration, link.close));

    // when we recall the provider again
    // the timer will be canceled and the link will no longer close.
    onResume(() => timer?.cancel());

    /// if the link is closed, [onDispose] will be called
    /// and if there's a timer it will be canceled
    onDispose(() => timer?.cancel());

    return link;
  }

  Future<void> debounce([Duration duration = const Duration(milliseconds: 250)]) async {
    final completer = Completer<void>();
    final timer = Timer(duration, () {
      if (!completer.isCompleted) completer.complete();
    });

    onDispose(() {
      timer.cancel();
      if (!completer.isCompleted) completer.completeError(StateError('cancelled'));
    });

    return completer.future;
  }
}
