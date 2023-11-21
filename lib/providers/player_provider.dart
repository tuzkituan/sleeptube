import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sleeptube/models/PlayingVideoModel.dart';
import 'package:sleeptube/models/PopularVideosResponse.dart';
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

  void onGetVideoInfo(Items item) async {
    var yt = YoutubeExplode();
    Video video = await yt.videos.get('https://youtube.com/watch?v=${item.id}');
    currentVideo = PlayingVideoModal.fromJson({
      "title": video.title.toString(),
      "author": video.author.toString(),
      "channelId": video.channelId.toString(),
      "uploadDate": video.uploadDate.toString(),
      "description": video.description.toString()
    });
    notifyListeners();
  }

  void onStartPlay(Items item) async {
    onGetVideoInfo(item);
    var yt = YoutubeExplode();
    var manifest = await yt.videos.streamsClient.getManifest(item.id);
    var streamInfo = manifest.audioOnly.withHighestBitrate();
    await audioPlayer.setUrl(streamInfo.url.toString());
    isLoaded = true;
    onPlay();
    notifyListeners();
  }
}
