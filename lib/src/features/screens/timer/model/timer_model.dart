import 'dart:async';
import 'package:flutter/material.dart';

class TimerModel {
  Timer? _timer;
  final int _initialMinutes = 1;
  final int _initialSeconds = 0;
  final ValueNotifier<int> totalSeconds;

  TimerModel() : totalSeconds = ValueNotifier<int>((1 * 60) + 0);

  Future<void> startTimer() async {
    if (_timer != null && _timer!.isActive) {
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (totalSeconds.value > 0) {
        totalSeconds.value--;
      } else {
        await stopTimer();
      }
    });
  }

  Future<void> stopTimer() async {
    _timer?.cancel();
  }

  Future<void> resetTimer() async {
    await stopTimer();
    totalSeconds.value = (_initialMinutes * 60) + _initialSeconds;
  }

  Future<void> setTime(BuildContext context) async {
    TextEditingController minutesController =
        TextEditingController(text: (totalSeconds.value ~/ 60).toString());
    TextEditingController secondsController =
        TextEditingController(text: (totalSeconds.value % 60).toString());

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Set Timer'),
          content: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: minutesController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Minutes',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: secondsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Seconds',
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                int minutes = int.tryParse(minutesController.text) ?? _initialMinutes;
                int seconds = int.tryParse(secondsController.text) ?? _initialSeconds;
                totalSeconds.value = (minutes * 60) + seconds;
                Navigator.of(context).pop();
              },
              child: const Text('Set'),
            ),
          ],
        );
      },
    );
  }

  void dispose() {
    _timer?.cancel();
    totalSeconds.dispose();
  }
}

