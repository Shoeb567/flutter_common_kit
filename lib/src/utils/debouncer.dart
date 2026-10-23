import 'dart:async';
import 'package:flutter/foundation.dart';

/// Helper to debounce rapid events (e.g. search query typing).
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 300)});

  /// Runs the [action] after [delay] has elapsed without new calls.
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// Cancels any currently pending debounced task.
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Disposes internal resources.
  void dispose() {
    cancel();
  }
}

/// Helper to throttle rapid events so an action is executed at most once per [duration].
class Throttler {
  final Duration duration;
  bool _isThrottled = false;
  Timer? _timer;

  Throttler({this.duration = const Duration(milliseconds: 500)});

  /// Runs [action] immediately if not throttled, then blocks subsequent calls
  /// until [duration] has passed.
  void run(VoidCallback action) {
    if (_isThrottled) return;

    _isThrottled = true;
    action();

    _timer = Timer(duration, () {
      _isThrottled = false;
    });
  }

  /// Disposes internal resources.
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _isThrottled = false;
  }
}
