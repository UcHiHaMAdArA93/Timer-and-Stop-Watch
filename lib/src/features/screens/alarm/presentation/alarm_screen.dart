import 'package:flutter/material.dart';

class Alarm extends StatefulWidget {
  const Alarm({super.key});

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
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
        ],
      )
    );
  }
}