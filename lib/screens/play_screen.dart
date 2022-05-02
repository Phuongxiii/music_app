// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:music_app/components/colors.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayScreen extends StatefulWidget {
  YouTubeVideo video;
  PlayScreen({Key? key, required this.video}) : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen>
    with SingleTickerProviderStateMixin {
  late YoutubePlayerController _controller;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller = YoutubePlayerController(
        initialVideoId: widget.video.id!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          loop: true,
          mute: false,
        ));
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
          backgroundColor: AppColor.backGroundColor,
          body: Column(
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () {},
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.line_style)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                  IconButton(
                      onPressed: () {},
                      icon: AnimatedIcon(
                          icon: AnimatedIcons.add_event,
                          progress: _animationController)),
                ],
              ),
              Text(
                widget.video.title,
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 24,
                ),
              ),
            ],
          )),
    );
  }
}
