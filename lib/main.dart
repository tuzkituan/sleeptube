import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleeptube/components/logo/logo.dart';
import 'package:sleeptube/utils/constants.dart';
import 'package:sleeptube/views/home/home.dart';

void main() {
  runApp(const MyApp());
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.chakraPetchTextTheme(baseTheme.textTheme),
    // canvasColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget renderMediaButton(IconData icon, void Function()? onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Icon(icon),
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConst.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      scrollBehavior: MyCustomScrollBehavior(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
          title: const Logo(),
        ),
        bottomNavigationBar: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(
            horizontal: MyConst.CONTAINER_PADDING,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: MyConst.MAIN_COLOR,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Hello Vietnam",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Justin Baby",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    renderMediaButton(
                      Icons.skip_previous,
                      () {},
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    renderMediaButton(
                      Icons.pause,
                      () {},
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    renderMediaButton(
                      Icons.skip_next,
                      () {},
                    ),
                  ],
                )
              ]),
        ),
        body: const Home(),
      ),
    );
  }
}

// Enable scrolling with mouse dragging
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
