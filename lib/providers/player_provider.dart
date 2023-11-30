import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sleeptube/models/PlayingVideoModel.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class PlayerProvider with ChangeNotifier {
  AudioPlayer audioPlayer = AudioPlayer();
  PlayingVideoModal currentVideo = PlayingVideoModal();
  bool isLoaded = false;
  bool isPlaying = false;

  void onPlay() async {
    isPlaying = true;
    notifyListeners();
    await audioPlayer.play();
  }

  void onPause() async {
    isPlaying = false;
    notifyListeners();
    await audioPlayer.pause();
  }

  void onGetVideoInfo(String id) async {
    if (id.isNotEmpty) {
      var yt = YoutubeExplode();
      Video video = await yt.videos.get('https://youtube.com/watch?v=${id}');
      currentVideo = PlayingVideoModal.fromJson({
        "id": id.toString(),
        "title": video.title.toString(),
        "author": video.author.toString(),
        "channelId": video.channelId.toString(),
        "uploadDate": video.uploadDate.toString(),
        "description": video.description.toString(),
        "thumbnail": video.thumbnails.mediumResUrl.toString()
      });
      notifyListeners();
    }
  }

  void onStartPlay(String id) async {
    if (id.isNotEmpty) {
      onGetVideoInfo(id);
      var yt = YoutubeExplode();
      var manifest = await yt.videos.streamsClient.getManifest(id);
      var streamInfo = manifest.audioOnly.withHighestBitrate();
      await audioPlayer.setUrl(streamInfo.url.toString());
      isLoaded = true;
      onPlay();
      notifyListeners();
    }
  }
}
