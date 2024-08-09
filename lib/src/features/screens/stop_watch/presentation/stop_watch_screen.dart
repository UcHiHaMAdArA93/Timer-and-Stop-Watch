import 'package:flutter/material.dart';
import 'package:timer_app/src/features/screens/stop_watch/model/stop_watch_model.dart';


class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  late StopwatchModel _stopwatchModel;

  @override
  void initState() {
    super.initState();
    _stopwatchModel = StopwatchModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/timer_app_image.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 15,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.chevron_left,
                size: 32,
                color: Colors.black,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ValueListenableBuilder<String>(
                  valueListenable: _stopwatchModel.elapsedTimeString,
                  builder: (context, elapsedTime, child) {
                    return Container(
                      width: 220,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      child: Text(
                        elapsedTime,
                        style: const TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: _stopwatchModel.isRunning,
                      builder: (context, isRunning, child) {
                        return ElevatedButton(
                          onPressed: () async {
                            await _stopwatchModel.startStopwatch();
                          },
                          child: Text(isRunning ? 'Stop' : 'Start'),
                        );
                      },
                    ),
                    const SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        await _stopwatchModel.resetStopwatch();
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _stopwatchModel.dispose();
    super.dispose();
  }
}
