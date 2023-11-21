import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleeptube/components/search_input/search_input.dart';
import 'package:sleeptube/models/PlayingVideoModel.dart';
import 'package:sleeptube/models/PopularVideosResponse.dart';
import 'package:sleeptube/providers/player_provider.dart';
import 'package:sleeptube/providers/youtube_provider.dart';
import 'package:sleeptube/utils/color.dart';
import 'package:sleeptube/utils/constants.dart';

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

  void onSelectVideo(Items item) async {
    PlayerProvider playerProvider =
        Provider.of<PlayerProvider>(context, listen: false);
    playerProvider.onStartPlay(item);
  }

  @override
  Widget build(BuildContext context) {
    PopularVideosResponse? popularVideosResponse =
        Provider.of<YoutubeProvider>(context).popularVideos;
    List<Items>? items = popularVideosResponse?.items;

    PlayerProvider playerProvider = Provider.of<PlayerProvider>(context);
    PlayingVideoModal currentVideo = playerProvider.currentVideo;

    if (items == null) {
      return Container();
    }
    return Column(
      children: [
        Flexible(
          child: ListView(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: MyConst.CONTAINER_PADDING,
                  right: MyConst.CONTAINER_PADDING,
                  bottom: 8.0,
                  top: 4.0,
                ),
                child: SearchInput(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: MyConst.CONTAINER_PADDING,
                  vertical: MyConst.CONTAINER_PADDING / 2,
                ),
                child: Text(
                  "Popular Videos",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              ListView.separated(
                controller: _scrollController,
                itemCount: items.length + 1,
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.grey[900],
                  );
                },
                itemBuilder: (context, index) {
                  if (index < items.length) {
                    return GestureDetector(
                      onTap: () => onSelectVideo(items[index]),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: MyConst.CONTAINER_PADDING,
                          vertical: 6.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: currentVideo.id == items[index].id
                                ? COLOR_C
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 8.0,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4.0),
                                      child: Image.network(
                                        items[index]
                                            .snippet!
                                            .thumbnails!
                                            .def!
                                            .url!,
                                        height: 44,
                                        width: 44,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 18,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            items[index].snippet!.title!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            items[index].snippet!.channelTitle!,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              IconButton(
                                iconSize: 22,
                                icon: const Icon(
                                  Icons.more_vert,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
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
              ),
            ],
          ),
        )
      ],
    );
  }
}
