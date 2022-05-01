import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/components/colors.dart';
import 'package:music_app/screens/search_screen.dart';

class CustomSliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColor.backGroundColor,
      floating: true,
      leadingWidth: 45.0,
      leading: SvgPicture.asset('assets/icons8-pandora-app.svg',
      width: 35,
      height: 35,
      color: Colors.white,
      ),
      actions: [
        IconButton(
          iconSize: 64.0,
          icon: SvgPicture.asset('assets/icons8-search (1).svg',
          width: 64.0,
          height: 64.0,
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
