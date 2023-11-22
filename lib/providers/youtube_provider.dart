import 'package:flutter/material.dart';
import 'package:sleeptube/models/PopularVideosResponse.dart';
import 'package:sleeptube/models/SearchResponse.dart';
import 'package:sleeptube/services/youtube_service.dart';

class YoutubeProvider with ChangeNotifier {
  final YoutubeService _youtubeService = YoutubeService();

  PopularVideosResponse? popularVideos;
  SearchResponse? searchVideos;
  bool? isSearching = false;

  Future<void> getPopularVideo(params) async {
    try {
      notifyListeners();
      dynamic response = await _youtubeService.getPopularVideo(params);
      notifyListeners();
      // print("response: $response");
      if (response != null) {
        popularVideos = PopularVideosResponse.fromJson(response);
        searchVideos = null;
        isSearching = false;
        notifyListeners();
      }
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
