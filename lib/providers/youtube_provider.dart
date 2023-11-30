import 'package:flutter/material.dart';
import 'package:sleeptube/models/PopularVideosResponse.dart';
import 'package:sleeptube/models/SearchResponse.dart';
import 'package:sleeptube/services/youtube_service.dart';

class YoutubeProvider with ChangeNotifier {
  final YoutubeService _youtubeService = YoutubeService();

  PopularVideosResponse? popularVideoResponse;
  String nextPageToken = "";
  bool? popularVideoLoading = false;

  SearchResponse? searchVideos;
  bool? isSearching = false;

  Future<void> getPopularVideo(
      {required Map<String, dynamic> params, bool isLoadMore = false}) async {
    popularVideoLoading = true;

    try {
      notifyListeners();
      dynamic finalParams = isLoadMore && nextPageToken.isNotEmpty
          ? {"pageToken": nextPageToken, ...params}
          : params;

      dynamic response = await _youtubeService.getPopularVideo(finalParams);
      notifyListeners();
      if (response != null && response != false) {
        PopularVideosResponse temp = PopularVideosResponse.fromJson(response);
        print("nextPageToken: ${temp.nextPageToken}");
        if (!isLoadMore) {
          popularVideoResponse = temp;
        } else {
          popularVideoResponse!.items!.addAll(temp.items!);
        }
        nextPageToken = temp.nextPageToken ?? "";
        searchVideos = null;
        isSearching = false;
      }
      popularVideoLoading = false;
      notifyListeners();
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }

  Future<void> searchVideo(params) async {
    try {
      dynamic response = await _youtubeService.searchVideos(params);
      notifyListeners();
      // print("search response: $response");
      if (response != null) {
        searchVideos = SearchResponse.fromJson(response);
        isSearching = true;
        notifyListeners();
      }
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
}
