import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          width: 24,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            color: COLOR_E,
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
        Text(
          "Music",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.4,
            fontFamily: GoogleFonts.oswaldTextTheme().labelMedium?.fontFamily,
          ),
        ),
        // Text(
        //   "TUBE",
        //   style: TextStyle(
        //     color: COLOR_A,
        //     fontSize: 24,
        //     fontWeight: FontWeight.bold,
        //     letterSpacing: 1.4,
        //     fontFamily:
        //         GoogleFonts.robotoCondensedTextTheme().labelMedium?.fontFamily,
        //   ),
        // ),
      ],
    );
  }
}
