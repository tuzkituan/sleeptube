import 'package:flutter/material.dart';
import 'package:sleeptube/components/search_input/search_input.dart';
import 'package:sleeptube/utils/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  List<String> _dataList = List.generate(20, (index) => 'Item $index');

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
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Simulating a delay for fetching more data
      await Future.delayed(const Duration(seconds: 2));

      // Append new data to the existing list
      List<String> newDataList =
          List.generate(10, (index) => 'Item ${_dataList.length + index}');
      setState(() {
        _dataList.addAll(newDataList);
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ListView(
            shrinkWrap: true,
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
              ListView.separated(
                controller: _scrollController,
                itemCount: _dataList.length + 1,
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
                  if (index < _dataList.length) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: MyConst.CONTAINER_PADDING,
                        vertical: 12.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(2.0),
                                child: Image.network(
                                  "https://upload.wikimedia.org/wikipedia/commons/e/ee/Sample_abc.jpg",
                                  height: 50,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _dataList[index],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    _dataList[index],
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.play_arrow,
                            ),
                            onPressed: () {},
                          ),
                        ],
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
