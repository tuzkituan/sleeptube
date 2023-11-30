import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleeptube/models/PlayingVideoModel.dart';
import 'package:sleeptube/providers/player_provider.dart';
import 'package:sleeptube/providers/youtube_provider.dart';
import 'package:sleeptube/utils/color.dart';
import 'package:sleeptube/utils/constants.dart';
import 'package:sleeptube/views/home/home.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  Future<void> getData({
    bool isLoadMore = false,
  }) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final youtubeProvider =
          Provider.of<YoutubeProvider>(context, listen: false);
      youtubeProvider.getPopularVideo(
        params: {
          "part": "snippet",
          "chart": "mostPopular",
          "regionCode": "vn",
          "maxResults": "15",
          "videoCategoryId": "10"
        },
        isLoadMore: isLoadMore,
      );
    });
  }

  Future<void> onLoadMore() async {
    getData(isLoadMore: true);
  }

  @override
  void initState() {
    super.initState();
    getData(isLoadMore: false);
  }

  Widget renderMediaButton(IconData icon, void Function()? onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: COLOR_D,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
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

    return Scaffold(
      extendBody: false,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   foregroundColor: Colors.white,
      //   scrolledUnderElevation: 0.0,
      //   elevation: 0,
      //   toolbarHeight: 0,
      // ),
      extendBodyBehindAppBar: false,
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: COLOR_D,
        ),
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: MyConst.CONTAINER_PADDING,
                right: MyConst.CONTAINER_PADDING,
                top: 0,
                bottom: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (currentVideo.thumbnail != null) ...[
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network(
                            currentVideo.thumbnail!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentVideo.title ?? "Unknown",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: COLOR_A,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 4,
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
                      renderMediaButton(
                        Icons.skip_previous,
                        () {},
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
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
                      const SizedBox(
                        width: 4.0,
                      ),
                      renderMediaButton(
                        Icons.skip_next,
                        () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),

      body: Home(
        onLoadMore: onLoadMore,
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
