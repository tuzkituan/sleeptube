import 'package:flutter/material.dart';
import 'package:sleeptube/models/PopularVideosResponse.dart';
import 'package:sleeptube/services/youtube_service.dart';

class YoutubeProvider with ChangeNotifier {
  final YoutubeService _youtubeService = YoutubeService();

  PopularVideosResponse? popularVideos;

  Future<void> getPopularVideo(params) async {
    try {
      notifyListeners();
      dynamic response = await _youtubeService.getPopularVideo(params);
      notifyListeners();
      if (response != null) {
        popularVideos = PopularVideosResponse.fromJson(response);
        notifyListeners();
      }
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
}
