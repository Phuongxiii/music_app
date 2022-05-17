// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:music_app/components/colors.dart';
import 'package:music_app/firebase.dart';
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
  var db = FirebaseFirestore.instance;
  late bool exist;
  late QueryDocumentSnapshot<Map<String, dynamic>> document;

  @override
  void initState() {
    super.initState();
    exist = false;
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller = YoutubePlayerController(
        initialVideoId: widget.video.id!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          loop: true,
          mute: false,
        ));
    getData(widget.video.id!);
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void PushData(String id) {
    final user = <String, dynamic>{"id": id};
    db.collection("yoytube-clone").add(user).then((value) => print(value));
  }

  Future<void> getData(String id) async {
    await db.collection("yoytube-clone").get().then((event) {
      for (var doc in event.docs) {
        if (doc.data()["id"] == widget.video.id) {
          document = doc;
          exist = true;
        }
        setState(() {});
        print("${doc.data()} => ${doc.data()}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const Spacer(),
                IconButton(
                    color: Colors.white,
                    onPressed: () {},
                    icon: const Icon(Icons.line_style)),
                const Spacer(),
                IconButton(
                    color: Colors.white,
                    onPressed: () {},
                    icon: const Icon(Icons.share)),
                const Spacer(),
                IconButton(
                  color: Colors.white,
                  onPressed: () {
                    if (exist == true) {
                      db
                          .collection('youtube-clone')
                          .doc('youtube-clone/${document.id}')
                          .delete()
                          .then((value) {
                        print("delete ${document.id}");
                      });
                    } else {
                      PushData(widget.video.id!);
                    }
                    setState(() {
                      exist = !exist;
                      getData(widget.video.id!);
                    });
                  },
                  icon:
                      exist ? const Icon(Icons.delete) : const Icon(Icons.add),
                ),
                const Spacer(),
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
        ));
  }
}
