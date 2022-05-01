import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:youtube_api/youtube_api.dart';

class ConnectApi {
  static String key = "AIzaSyA3YEflFlVxNsaYltQ_XpFgtBLbTkIWO7s";

  YoutubeAPI youtube = YoutubeAPI(key);
  List<YouTubeVideo> videoResult = [];
  Future<void> callAPI(String query) async {
    videoResult = await youtube.search(
      query,
      order: 'relevance',
      videoDuration: 'any',
    );
  }

  getYoutubeVideo() {
    return youtube;
  }

  getData(String query) {
    callAPI(query);
    if (videoResult.length > 0) {
      return videoResult;
    }
  }
}
