import 'package:flutter/material.dart';
import 'package:timer_app/src/features/screens/alarm/presentation/alarm_screen.dart';
import 'package:timer_app/src/features/screens/timer/presentation/timer_screen.dart';
import 'package:timer_app/src/features/screens/stop_watch/presentation/stop_watch_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(
                      context,
                     MaterialPageRoute(builder: (context) => const TimerScreen()),
                    );
                    }, child: const Text("Timer"),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(
                      context,
                     MaterialPageRoute(builder: (context) => const StopWatch()),
                    );
                    }, child: const Text("Stop Watch"),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(
                      context,
                     MaterialPageRoute(builder: (context) => const Alarm()),
                    );
                    }, child: const Text("Alarm"),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]
      )
    );
  }
}