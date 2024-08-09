import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchModel {
/*final Stopwatch _stopwatch = Stopwatch();: This initializes a private Stopwatch instance from Dart's core library. 
The Stopwatch class is used to measure elapsed time.
final ValueNotifier<String> elapsedTimeString = ValueNotifier<String>("00:00.0");: This creates a ValueNotifier that holds a string representing the formatted 
elapsed time (initially set to "00:00.0"). ValueNotifier is used to notify listeners (e.g., UI widgets) whenever the value changes.
final ValueNotifier<bool> isRunning = ValueNotifier<bool>(false);: This creates another ValueNotifier, which holds a boolean 
value indicating whether the stopwatch is running or not (initially set to false).
Timer? _timer;: This declares a nullable Timer variable. This Timer will be used to periodically update the elapsed time.*/

  final Stopwatch _stopwatch = Stopwatch();
  final ValueNotifier<String> elapsedTimeString = ValueNotifier<String>("00:00.0");
  final ValueNotifier<bool> isRunning = ValueNotifier<bool>(false);
  Timer? _timer;

  /*_timer = Timer.periodic(...): This sets up a periodic timer that triggers every 100 milliseconds.
if (_stopwatch.isRunning) {...}: Inside the timer callback, the code checks if the stopwatch is running. 
If it is, it calls _updateElapsedTime() to update the elapsed time string.*/


  StopwatchModel() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      if (_stopwatch.isRunning) {
        _updateElapsedTime();
      }
    });
  }

  /*startStopwatch: This method starts or stops the stopwatch depending on its current state.
if (!_stopwatch.isRunning) {...}: If the stopwatch is not running, it starts the stopwatch and sets isRunning.value to true.
else {...}: If the stopwatch is already running, it stops the stopwatch and sets isRunning.value to false.*/

  Future<void> startStopwatch() async {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      isRunning.value = true; 
    } else {
      _stopwatch.stop();
      isRunning.value = false; 
    }
  }

  /*resetStopwatch: This method resets the stopwatch, updates the elapsed time to reflect the reset state, and sets isRunning.value to false.
_stopwatch.reset();: Resets the stopwatch to zero.
_updateElapsedTime();: Updates the elapsed time string to "00:00.0".
isRunning.value = false;: Sets the isRunning state to false.*/

  Future<void> resetStopwatch() async {
    _stopwatch.reset();
    _updateElapsedTime();
    isRunning.value = false; 
  }

  /*_updateElapsedTime: This private method updates the elapsedTimeString to the current elapsed time.
final elapsedTime = _stopwatch.elapsed;: Retrieves the total elapsed time since the stopwatch started.
elapsedTimeString.value = _formatElapsedTime(elapsedTime);: Converts the elapsed time to a formatted string and 
updates elapsedTimeString.value.*/


  void _updateElapsedTime() {
    final elapsedTime = _stopwatch.elapsed;
    elapsedTimeString.value = _formatElapsedTime(elapsedTime);
  }

  /*_formatElapsedTime: This private method takes a Duration object and converts it into a human-readable string in the format "MM
.D".
time.inMinutes.remainder(60): Calculates the minutes part.
time.inSeconds.remainder(60): Calculates the seconds part.
time.inMilliseconds % 1000 ~/ 100: Calculates the tenths of a second part.
padLeft(2, '0'): Ensures that minutes and seconds are always displayed with two digits, padding with a leading zero if necessary.*/

  String _formatElapsedTime(Duration time) {
    return '${time.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(time.inSeconds.remainder(60)).toString().padLeft(2, '0')}.${(time.inMilliseconds % 1000 ~/ 100).toString()}';
  }

  /*dispose: This method is called when the StopwatchModel is no longer needed, typically to release resources.
_timer?.cancel();: Cancels the periodic timer to stop it from triggering anymore.
elapsedTimeString.dispose();: Disposes of the ValueNotifier for elapsedTimeString.
isRunning.dispose();: Disposes of the ValueNotifier for isRunning.*/

  void dispose() {
    _timer?.cancel();
    elapsedTimeString.dispose();
    isRunning.dispose();
  }
}
