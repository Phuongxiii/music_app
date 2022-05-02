import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_app/components/colors.dart';
import 'package:music_app/screens/result_screen.dart';
import 'package:youtube_api/youtube_api.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;
  static String key = "AIzaSyA3YEflFlVxNsaYltQ_XpFgtBLbTkIWO7s";

  YoutubeAPI youtube = YoutubeAPI(key);
  List<YouTubeVideo> videoResult = [];
  Future<void> callAPI(String query) async {
    videoResult =
        await youtube.search(query, order: 'relevance', type: 'video');
    videoResult = await youtube.nextPage();
    Navigator.of(context).push(_createRoute(videoResult));
  }

  late List<YouTubeVideo> videoList;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.componentColor,
          flexibleSpace: TextField(
            controller: _controller,
            autofocus: true,
            textAlign: TextAlign.center,
            onSubmitted: (Text) {
              callAPI(Text);
            },
          ),
        ),
        body: Container(),
        backgroundColor: AppColor.backGroundColor,
      ),
    );
  }
}

Route _createRoute(List<YouTubeVideo> videoList) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ResultScreen(
            videoList: videoList,
          ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
