import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_app/components/colors.dart';
import 'package:music_app/connect_to_youtube_api.dart';
import 'package:music_app/screens/result_screen.dart';
import 'package:youtube_api/youtube_api.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;
  late String TextSearch;
  late List<YouTubeVideo> videoList;
  late ConnectApi _connectApi;
  @override
  void initState() {
    super.initState();
    _connectApi = ConnectApi();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.componentColor,
        flexibleSpace: TextField(
          controller: _controller,
          autofocus: true,
          textAlign: TextAlign.center,
          onSubmitted: (Text) {
            videoList = _connectApi.getData(Text);
            Navigator.of(context).push(_createRoute(videoList));
            print(videoList.length);
          },
        ),
      ),
      body: Container(),
      backgroundColor: AppColor.backGroundColor,
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
