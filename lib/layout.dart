import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleeptube/components/logo/logo.dart';
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
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: COLOR_C,
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
      extendBody: true,
      appBar: AppBar(
        backgroundColor: COLOR_E,
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
              onPressed: () {
                showSearch(context: context, delegate: Search([]));
              },
              iconSize: 20,
              icon: const Icon(Icons.search),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          const Home(),
          Positioned(
            bottom: MyConst.CONTAINER_PADDING,
            left: 0,
            right: 0,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: COLOR_D,
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: MyConst.CONTAINER_PADDING / 2,
                vertical: MyConst.CONTAINER_PADDING / 2,
              ),
              child: Column(
                children: [
                  // Transform.translate(
                  //   offset: const Offset(0, 0),
                  //   child: StreamBuilder(
                  //       stream:
                  //           playerProvider.audioPlayer.positionStream,
                  //       builder: (context, snapshot1) {
                  //         final Duration duration =
                  //             playerProvider.isLoaded &&
                  //                     snapshot1.hasData
                  //                 ? snapshot1.data as Duration
                  //                 : const Duration(seconds: 0);
                  //         return StreamBuilder(
                  //             stream: playerProvider
                  //                 .audioPlayer.bufferedPositionStream,
                  //             builder: (context, snapshot2) {
                  //               final Duration bufferedDuration =
                  //                   playerProvider.isLoaded &&
                  //                           snapshot2.hasData
                  //                       ? snapshot2.data as Duration
                  //                       : const Duration(seconds: 0);
                  //               return ProgressBar(
                  //                 progress: duration,
                  //                 total: playerProvider
                  //                         .audioPlayer.duration ??
                  //                     const Duration(seconds: 0),
                  //                 buffered: bufferedDuration,
                  //                 timeLabelLocation:
                  //                     TimeLabelLocation.none,
                  //                 progressBarColor: COLOR_A,
                  //                 baseBarColor: Colors.grey[900],
                  //                 bufferedBarColor: COLOR_C,
                  //                 thumbColor: COLOR_A,
                  //                 barHeight: 2,
                  //                 thumbRadius: 0,
                  //                 onSeek: playerProvider.isLoaded
                  //                     ? (duration) async {
                  //                         await playerProvider
                  //                             .audioPlayer
                  //                             .seek(duration);
                  //                       }
                  //                     : null,
                  //               );
                  //             });
                  //       }),
                  // ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: MyConst.CONTAINER_PADDING,
                        right: MyConst.CONTAINER_PADDING,
                        top: 0.0,
                        bottom: 0.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
            ),
          ),
        ],
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

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
Widget buildResults(BuildContext context) {
  return FutureBuilder(
    future: News.fetchArticle,
    builder: (context, AsyncSnapshot<List<Article>> snapshot) {
      if(snapshot != null)
        return Text("No articles found!");
      else {
        return ListView.builder(
          itemCount: snapshot.data.length,
          builder: (context, pos) {
            ....
          }
        );
      }
    }
  );
}

  final List<String> listExample;
  Search(this.listExample);

  List<String> recentList = [];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
            // In the false case
            (element) => element.contains(query),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading:
              query.isEmpty ? const Icon(Icons.access_time) : const SizedBox(),
          onTap: () {
            // selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
