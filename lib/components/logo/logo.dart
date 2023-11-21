import 'package:flutter/material.dart';
import 'package:sleeptube/utils/color.dart';
import 'package:sleeptube/utils/constants.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: COLOR_C,
          ),
          padding: const EdgeInsets.all(2.0),
          child: const Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 18,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        const Text(
          "SLEEP",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.4,
          ),
        ),
        Text(
          "TUBE",
          style: TextStyle(
            color: COLOR_A,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.4,
          ),
        ),
      ],
    );
  }
}
