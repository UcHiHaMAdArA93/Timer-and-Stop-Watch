import 'dart:async';
import 'package:flutter/material.dart';

/*_timer: This is a private variable of type Timer?, used to keep track of the timer instance. The Timer class is from the dart:async library 
and is used to trigger actions periodically or after a delay.
_initialMinutes and _initialSeconds: These are constants representing the default starting time for the timer, set to 1 minute and 0 seconds.
totalSeconds: This is a ValueNotifier<int> that notifies its listeners whenever the value 
changes. It holds the current time remaining on the timer, in seconds.*/

class TimerModel {
  Timer? _timer;
  final int _initialMinutes = 1;
  final int _initialSeconds = 0;
  final ValueNotifier<int> totalSeconds;

  /*TimerModel: The constructor initializes the totalSeconds to the total number of seconds 
  derived from the initial minutes and seconds (1 minute * 60 seconds + 0 seconds = 60 seconds).*/

  TimerModel() : totalSeconds = ValueNotifier<int>((1 * 60) + 0);

  /*startTimer(): This method starts the countdown timer.
_timer != null && _timer!.isActive: If the timer is already active, the method returns early to prevent starting multiple timers.
Timer.periodic(const Duration(seconds: 1), (timer) async {...}): This sets up a periodic timer that triggers every second (Duration(seconds: 1)).
totalSeconds.value--: Decrements the totalSeconds by 1 every second.
await stopTimer();: If totalSeconds reaches 0, the timer is stopped.*/

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

  /*stopTimer(): This method stops the timer by canceling the _timer if it exists (_timer?.cancel()).*/

  Future<void> stopTimer() async {
    _timer?.cancel();
  }

  /*resetTimer(): This method stops the timer and resets the totalSeconds to the initial value (1 minute, or 60 seconds).*/

  Future<void> resetTimer() async {
    await stopTimer();
    totalSeconds.value = (_initialMinutes * 60) + _initialSeconds;
  }

  /*setTime(BuildContext context): This method shows a dialog allowing the user to set the timer's duration.
TextEditingController: Controllers for text fields that will pre-populate the fields with the current minutes and seconds.
totalSeconds.value ~/ 60: Integer division to get the current minutes.
totalSeconds.value % 60: Modulus operation to get the remaining seconds.*/

  Future<void> setTime(BuildContext context) async {
    TextEditingController minutesController =
        TextEditingController(text: (totalSeconds.value ~/ 60).toString());
    TextEditingController secondsController =
        TextEditingController(text: (totalSeconds.value % 60).toString());

        /*showDialog: Displays a dialog where users can input the desired minutes and seconds.
AlertDialog: The dialog widget with two TextFields to enter minutes and seconds.
TextButton: Buttons to either cancel or set the new time.
Cancel: Closes the dialog without saving changes.
Set: Parses the input values, calculates the new total time in seconds, updates totalSeconds, and closes the dialog.
Input Parsing:
int.tryParse(...): Attempts to parse the text input as an integer. If parsing fails, it defaults to the initial minutes or seconds.
totalSeconds.value = (minutes * 60) + seconds: Updates totalSeconds with the new value.*/

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

  /*dispose(): This method is used to clean up resources when the TimerModel is no longer needed.
_timer?.cancel(): Stops the timer if it's running.
totalSeconds.dispose(): Disposes the ValueNotifier to free up resources and prevent memory leaks.*/

  void dispose() {
    _timer?.cancel();
    totalSeconds.dispose();
  }
}

