import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/components/colors.dart';
import 'package:music_app/screens/search_screen.dart';

class CustomSliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(top: 4.0, bottom: 160.0),
        title: const Text('Music App'),
        centerTitle: true,
        background: AnimatedOpacity(
          duration: const Duration(seconds: 1),
          opacity: 0.8,
          child: Image.asset(
            "assets/85fffbc14f24b6eb9da5ff9768ff3b1f.jpg",
            fit: BoxFit.cover,
          ),
        ),
        // ignore: prefer_const_literals_to_create_immutables
        stretchModes: [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
      ),
      backgroundColor: AppColor.backGroundColor,
      floating: true,
      leadingWidth: 45.0,
      leading: SvgPicture.asset(
        'assets/icons8-pandora-app.svg',
      width: 35,
        height: 35,
        color: Colors.white,
      ),
      actions: [
        IconButton(
          iconSize: 48.0,
          icon: SvgPicture.asset('assets/icons8-search (1).svg',
            width: 48.0,
            height: 48.0,
          color: Colors.white,
          ),
          onPressed: () {
          Navigator.of(context).push(_createRoute());
          },
        ),
      ],
    );
  }
}


Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SearchScreen(),
transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
      });
}
