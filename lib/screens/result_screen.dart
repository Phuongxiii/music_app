import 'package:flutter/material.dart';
import 'package:music_app/components/button_menu.dart';
import 'package:music_app/components/colors.dart';
import 'package:music_app/screens/play_screen.dart';
import 'package:youtube_api/youtube_api.dart';

class ResultScreen extends StatefulWidget {
  List<YouTubeVideo> videoList;
  ResultScreen({Key? key, required this.videoList}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final bool hasPadding = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Result")),
        backgroundColor: AppColor.backGroundColor,
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 60.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final video = widget.videoList[index];
                    return VideoCard(video);
                  },
                  childCount: widget.videoList.length,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: ButtonMenu(),
      ),
    );
  }

  Widget VideoCard(YouTubeVideo video) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(_createRoute(video));
      },
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: hasPadding ? 12.0 : 0,
                ),
                child: Image.network(
                  video.thumbnail.high.url ?? '',
                  height: 220.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 8.0,
                right: hasPadding ? 20.0 : 8.0,
                child: Opacity(
                  opacity: 0.65,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    color: Colors.black,
                    child: Text(
                      video.duration ?? 'null',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColor.componentColor,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => print('Navigate to profile'),
                    child: const CircleAvatar(
                      child: Icon(Icons.people),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            video.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 15.0, color: Colors.white),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${video.channelTitle} • ${video.duration} views • ${video.publishedAt}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14.0, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.more_vert,
                      size: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Route _createRoute(YouTubeVideo video) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayScreen(
            video: video,
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
