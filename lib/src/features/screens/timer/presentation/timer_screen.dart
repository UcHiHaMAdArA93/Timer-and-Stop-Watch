import 'package:flutter/material.dart';
import 'package:timer_app/src/features/screens/timer/model/timer_model.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final TimerModel timerModel = TimerModel();

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
           Positioned (
            top: 80,
            left: 15,
            child:  GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.chevron_left, size: 32, 
              color: Colors.black, weight: 100,),
            )
            ),
          Positioned(
            top: 350,
            left: 10,
            right: 10,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => timerModel.setTime(context),
                      child: Container(
                        width: 220,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: ValueListenableBuilder<int>(
                            valueListenable: timerModel.totalSeconds,
                            builder: (context, totalSeconds, _) {
                              final minutes = totalSeconds ~/ 60;
                              final seconds = totalSeconds % 60;
                              return Text(
                                '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  fontSize: 48,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await timerModel.startTimer();
                          },
                          child: const Text("Start"),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                            await timerModel.stopTimer();
                          },
                          child: const Text("Stop"),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                            await timerModel.resetTimer();
                          },
                          child: const Text("Reset"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timerModel.dispose();
    super.dispose();
  }
}



