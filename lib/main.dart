import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sleeptube/components/logo/logo.dart';
import 'package:sleeptube/models/PlayingVideoModel.dart';
import 'package:sleeptube/providers/player_provider.dart';
import 'package:sleeptube/providers/youtube_provider.dart';
import 'package:sleeptube/utils/color.dart';
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
        ChangeNotifierProvider(create: (_) => PlayerProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
    // canvasColor: Colors.black,
    scaffoldBackgroundColor: COLOR_E,
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
        "videoCategoryId": "10"
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
          color: COLOR_C,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Icon(icon),
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    PlayerProvider playerProvider = Provider.of<PlayerProvider>(context);
    PlayingVideoModal currentVideo = playerProvider.currentVideo;

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
        bottomNavigationBar: playerProvider.isLoaded
            ? Container(
                height: 74,
                decoration: BoxDecoration(
                  color: COLOR_D,
                ),
                child: Column(
                  children: [
                    Transform.translate(
                      offset: const Offset(0, -4),
                      child: StreamBuilder(
                          stream: playerProvider.audioPlayer.positionStream,
                          builder: (context, snapshot1) {
                            final Duration duration =
                                playerProvider.isLoaded && snapshot1.hasData
                                    ? snapshot1.data as Duration
                                    : const Duration(seconds: 0);
                            return StreamBuilder(
                                stream: playerProvider
                                    .audioPlayer.bufferedPositionStream,
                                builder: (context, snapshot2) {
                                  final Duration bufferedDuration =
                                      playerProvider.isLoaded &&
                                              snapshot2.hasData
                                          ? snapshot2.data as Duration
                                          : const Duration(seconds: 0);
                                  return ProgressBar(
                                    progress: duration,
                                    total:
                                        playerProvider.audioPlayer.duration ??
                                            const Duration(seconds: 0),
                                    buffered: bufferedDuration,
                                    timeLabelLocation: TimeLabelLocation.none,
                                    progressBarColor: COLOR_A,
                                    baseBarColor: Colors.grey[600],
                                    bufferedBarColor: COLOR_C,
                                    thumbColor: COLOR_A,
                                    barHeight: 2,
                                    thumbRadius: 6,
                                    onSeek: playerProvider.isLoaded
                                        ? (duration) async {
                                            await playerProvider.audioPlayer
                                                .seek(duration);
                                          }
                                        : null,
                                  );
                                });
                          }),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: MyConst.CONTAINER_PADDING,
                          right: MyConst.CONTAINER_PADDING,
                          top: 0.0,
                          bottom: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    currentVideo.title ?? "Unknown",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      // color: MyConst.LIGHT_MAIN_COLOR,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    currentVideo.author ?? "Unknown",
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Row(
                              children: [
                                // renderMediaButton(
                                //   Icons.skip_previous,
                                //   () {},
                                // ),
                                // const SizedBox(
                                //   width: 4.0,
                                // ),
                                renderMediaButton(
                                  playerProvider.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  () {
                                    playerProvider.isPlaying
                                        ? playerProvider.onPause()
                                        : playerProvider.onPlay();
                                  },
                                ),
                                // const SizedBox(
                                //   width: 4.0,
                                // ),
                                // renderMediaButton(
                                //   Icons.skip_next,
                                //   () {},
                                // ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : null,
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
