import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:sleeptube/services/http_service.dart';

class YoutubeService {
  Future<dynamic> getPopularVideo(dynamic params) async {
    try {
      String api = "/youtube/v3/videos";
      dynamic response = await HttpService.getAPI(api, params);
      return json.decode(response);
    } on SocketException {
      // apiResponse.ApiError = ApiError(error: "Server error. Please retry");
    } /*  */
    return false;
  }

  Future<dynamic> searchVideos(dynamic params) async {
    try {
      String api = "/youtube/v3/search";
      dynamic response = await HttpService.getAPI(api, params);
      return json.decode(response);
    } on SocketException {
      // apiResponse.ApiError = ApiError(error: "Server error. Please retry");
    } /*  */
    return false;
  }
}
