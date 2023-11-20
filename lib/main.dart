import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleeptube/components/logo/logo.dart';
import 'package:sleeptube/providers/youtube_provider.dart';
import 'package:sleeptube/utils/constants.dart';
import 'package:sleeptube/views/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => YoutubeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.chakraPetchTextTheme(baseTheme.textTheme),
    // canvasColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final youtubeProvider =
          Provider.of<YoutubeProvider>(context, listen: false);
      youtubeProvider.getPopularVideo({
        "part": "snippet",
        "chart": "mostPopular",
        "regionCode": "vn",
        "maxResults": "15",
        // "videoCategoryId": "17"
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
      scrollBehavior: NoThumbScrollBehavior(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
          title: const Logo(),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: MyConst.CONTAINER_PADDING,
              ),
              child: IconButton(
                onPressed: () {},
                iconSize: 20,
                icon: const Icon(Icons.timer_outlined),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(
            horizontal: MyConst.CONTAINER_PADDING,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[900],
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Hello Vietnam",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyConst.LIGHT_MAIN_COLOR,
                      ),
                    ),
                    const Text(
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

class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
      };

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
