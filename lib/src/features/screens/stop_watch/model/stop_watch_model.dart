import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchModel {
  final Stopwatch _stopwatch = Stopwatch();
  final ValueNotifier<String> elapsedTimeString = ValueNotifier<String>("00:00.0");
  final ValueNotifier<bool> isRunning = ValueNotifier<bool>(false);
  Timer? _timer;

  StopwatchModel() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      if (_stopwatch.isRunning) {
        _updateElapsedTime();
      }
    });
  }

  Future<void> startStopwatch() async {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      isRunning.value = true; 
    } else {
      _stopwatch.stop();
      isRunning.value = false; 
    }
  }

  Future<void> resetStopwatch() async {
    _stopwatch.reset();
    _updateElapsedTime();
    isRunning.value = false; 
  }

  void _updateElapsedTime() {
    final elapsedTime = _stopwatch.elapsed;
    elapsedTimeString.value = _formatElapsedTime(elapsedTime);
  }

  String _formatElapsedTime(Duration time) {
    return '${time.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(time.inSeconds.remainder(60)).toString().padLeft(2, '0')}.${(time.inMilliseconds % 1000 ~/ 100).toString()}';
  }

  void dispose() {
    _timer?.cancel();
    elapsedTimeString.dispose();
    isRunning.dispose();
  }
}
