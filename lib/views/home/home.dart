import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleeptube/components/logo/logo.dart';
import 'package:sleeptube/components/search_input/search_input.dart';
import 'package:sleeptube/components/tag/tag.dart';
import 'package:sleeptube/components/video_item/video_item.dart';
import 'package:sleeptube/models/PlayingVideoModel.dart';
import 'package:sleeptube/models/PopularVideosResponse.dart';
import 'package:sleeptube/models/SearchResponse.dart';
import 'package:sleeptube/providers/player_provider.dart';
import 'package:sleeptube/providers/youtube_provider.dart';
import 'package:sleeptube/utils/color.dart';
import 'package:sleeptube/utils/constants.dart';

class Home extends StatefulWidget {
  final void Function()? onLoadMore;

  const Home({super.key, this.onLoadMore});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print("LOAD MORE!");
      widget.onLoadMore!();
    }
  }

  void onSelectVideo(String id) async {
    PlayerProvider playerProvider =
        Provider.of<PlayerProvider>(context, listen: false);
    playerProvider.onStartPlay(id);
  }

  // void onSearch(String searchValue) {
  //   final youtubeProvider =
  //       Provider.of<YoutubeProvider>(context, listen: false);
  //   youtubeProvider.searchVideo({
  //     "part": "snippet",
  //     "maxResults": "15",
  //     "q": searchValue,
  //   });
  // }

  Widget renderPopularList(
      List<PopularItems> items, String? playingId, bool? isLoading) {
    return ListView.separated(
      itemCount: items.length + 1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 1,
          height: 1,
          color: Colors.transparent,
        );
      },
      itemBuilder: (context, index) {
        if (index < items.length) {
          return VideoItem(
            onTap: onSelectVideo,
            isPlaying: playingId != null && playingId == items[index].id,
            id: items[index].id!,
            author: items[index].snippet!.channelTitle,
            thumbnailUrl: items[index].snippet!.thumbnails!.standard!.url,
            title: items[index].snippet!.title,
          );
        } else {
          // Show a loading indicator at the end of the list
          return isLoading == true
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox();
        }
      },
    );
  }

  // Widget renderSearchList(List<SearchItems> items, String? playingId) {
  //   return ListView.separated(
  //     controller: _scrollController,
  //     itemCount: items.length + 1,
  //     shrinkWrap: true,
  //     physics: const AlwaysScrollableScrollPhysics(),
  //     separatorBuilder: (context, index) {
  //       return Divider(
  //         thickness: 1,
  //         height: 1,
  //         color: Colors.grey[900],
  //       );
  //     },
  //     itemBuilder: (context, index) {
  //       if (index < items.length) {
  //         return VideoItem(
  //           onTap: onSelectVideo,
  //           isPlaying:
  //               playingId != null && playingId == items[index].id!.videoId,
  //           id: items[index].id!.videoId ?? "",
  //           author: items[index].snippet!.channelTitle,
  //           thumbnailUrl: items[index].snippet!.thumbnails!.def!.url ?? "",
  //           title: items[index].snippet!.title,
  //         );
  //       } else {
  //         // Show a loading indicator at the end of the list
  //         return _isLoading
  //             ? const Padding(
  //                 padding: EdgeInsets.symmetric(vertical: 16),
  //                 child: Center(
  //                   child: CircularProgressIndicator(),
  //                 ),
  //               )
  //             : const SizedBox();
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    PopularVideosResponse? popularVideosResponse =
        Provider.of<YoutubeProvider>(context).popularVideoResponse;
    List<PopularItems>? items = popularVideosResponse?.items;
    bool? isLoading = Provider.of<YoutubeProvider>(context).popularVideoLoading;
    // SearchResponse? searchResponse =
    //     Provider.of<YoutubeProvider>(context).searchVideos;
    // List<SearchItems>? searchItems = searchResponse?.items;
    // bool? isSearching = Provider.of<YoutubeProvider>(context).isSearching;

    PlayerProvider playerProvider = Provider.of<PlayerProvider>(context);
    PlayingVideoModal currentVideo = playerProvider.currentVideo;
    String? playingId = currentVideo.id;

    List<String> tags = [
      "Popular",
      "Latest",
      "Trending",
      "Popular",
      "Latest",
      "Trending",
      "Popular",
      "Latest",
      "Trending"
    ];

    return Container(
      padding: const EdgeInsets.only(
        top: MyConst.CONTAINER_PADDING * 2,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[COLOR_C, COLOR_E],
          stops: const [0, 0.6],
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MyConst.CONTAINER_PADDING,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Logo(),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 32,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(
              vertical: MyConst.CONTAINER_PADDING / 2,
              horizontal: MyConst.CONTAINER_PADDING,
            ),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: tags.length,
              itemBuilder: (context, index) {
                return Tag(
                  onTap: () {},
                  label: tags[index],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 10,
                );
              },
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: MyConst.CONTAINER_PADDING,
          //     vertical: MyConst.CONTAINER_PADDING,
          //   ),
          //   child: Text(
          //     "Popular Videos".toUpperCase(),
          //     style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          //           color: Colors.white,
          //           fontWeight: FontWeight.bold,
          //         ),
          //   ),
          // ),
          Expanded(
            child: (items != null)
                ? renderPopularList(items, playingId, isLoading)
                : Container(),
          ),
        ],
      ),
    );
  }
}
