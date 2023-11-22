import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleeptube/components/video_item/video_item.dart';
import 'package:sleeptube/models/PlayingVideoModel.dart';
import 'package:sleeptube/models/PopularVideosResponse.dart';
import 'package:sleeptube/models/SearchResponse.dart';
import 'package:sleeptube/providers/player_provider.dart';
import 'package:sleeptube/providers/youtube_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  // List<String> _dataList = List.generate(20, (index) => 'Item $index');

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
      // Load more data
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    // if (!_isLoading) {
    //   setState(() {
    //     _isLoading = true;
    //   });

    //   // Simulating a delay for fetching more data
    //   await Future.delayed(const Duration(seconds: 2));

    //   // Append new data to the existing list
    //   List<String> newDataList =
    //       List.generate(10, (index) => 'Item ${_dataList.length + index}');
    //   setState(() {
    //     _dataList.addAll(newDataList);
    //     _isLoading = false;
    //   });
    // }
  }

  void onSelectVideo(String id) async {
    print("id: $id");
    PlayerProvider playerProvider =
        Provider.of<PlayerProvider>(context, listen: false);
    playerProvider.onStartPlay(id);
  }

  void onSearch(String searchValue) {
    final youtubeProvider =
        Provider.of<YoutubeProvider>(context, listen: false);
    youtubeProvider.searchVideo({
      "part": "snippet",
      "maxResults": "15",
      "q": searchValue,
    });
  }

  Widget renderPopularList(List<PopularItems> items, String? playingId) {
    return ListView.separated(
      controller: _scrollController,
      itemCount: items.length + 1,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 1,
          height: 1,
          color: Colors.grey[900],
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
          return _isLoading
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

  Widget renderSearchList(List<SearchItems> items, String? playingId) {
    return ListView.separated(
      controller: _scrollController,
      itemCount: items.length + 1,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 1,
          height: 1,
          color: Colors.grey[900],
        );
      },
      itemBuilder: (context, index) {
        if (index < items.length) {
          return VideoItem(
            onTap: onSelectVideo,
            isPlaying:
                playingId != null && playingId == items[index].id!.videoId,
            id: items[index].id!.videoId ?? "",
            author: items[index].snippet!.channelTitle,
            thumbnailUrl: items[index].snippet!.thumbnails!.def!.url ?? "",
            title: items[index].snippet!.title,
          );
        } else {
          // Show a loading indicator at the end of the list
          return _isLoading
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

  @override
  Widget build(BuildContext context) {
    PopularVideosResponse? popularVideosResponse =
        Provider.of<YoutubeProvider>(context).popularVideos;
    List<PopularItems>? items = popularVideosResponse?.items;
    SearchResponse? searchResponse =
        Provider.of<YoutubeProvider>(context).searchVideos;
    List<SearchItems>? searchItems = searchResponse?.items;
    bool? isSearching = Provider.of<YoutubeProvider>(context).isSearching;

    PlayerProvider playerProvider = Provider.of<PlayerProvider>(context);
    PlayingVideoModal currentVideo = playerProvider.currentVideo;
    String? playingId = currentVideo.id;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   padding: const EdgeInsets.only(
        //     left: MyConst.CONTAINER_PADDING * 3 / 4,
        //     right: MyConst.CONTAINER_PADDING * 3 / 4,
        //     bottom: MyConst.CONTAINER_PADDING / 2,
        //     top: MyConst.CONTAINER_PADDING,
        //   ),
        //   child: SearchInput(
        //     controller: _controller,
        //     onFinish: onSearch,
        //   ),
        // ),
        // if (isSearching == false)
        //   Padding(
        //     padding: const EdgeInsets.symmetric(
        //       horizontal: MyConst.CONTAINER_PADDING,
        //       vertical: MyConst.CONTAINER_PADDING,
        //     ),
        //     child: Text(
        //       "Popular Videos",
        //       style: Theme.of(context).textTheme.titleLarge?.copyWith(
        //             color: Colors.white,
        //             fontWeight: FontWeight.bold,
        //           ),
        //     ),
        //   ),
        Expanded(
          child: (searchItems != null)
              ? renderSearchList(searchItems, playingId)
              : (items != null)
                  ? renderPopularList(items, playingId)
                  : Container(),
        ),
      ],
    );
  }
}
