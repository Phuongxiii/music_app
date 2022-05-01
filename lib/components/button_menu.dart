import 'package:flutter/material.dart';
import 'package:music_app/components/colors.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ButtonMenu extends StatefulWidget {
  ButtonMenu({Key? key}) : super(key: key);

  @override
  State<ButtonMenu> createState() => _ButtonMenuState();
}

class _ButtonMenuState extends State<ButtonMenu> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: AppColor.buttonColor,
      children: [
        SpeedDialChild(
          label: 'List',
          backgroundColor: AppColor.buttonColor,
          onTap: (){},
          child: Image.asset('assets/icons8-list-100.png',
          width: 35,
          height: 35,
          )
        ),
        SpeedDialChild(
          label: 'History',
          backgroundColor: AppColor.buttonColor,
          onTap: (){},
          child: Image.asset('assets/icons8-history-64.png',
          width: 35,
          height: 35,
          )
        ),
        SpeedDialChild(
          label: 'Setting',
          onTap: (){},
          backgroundColor: AppColor.buttonColor,
          child: Image.asset('assets/icons8-setting-64.png',
          width: 35,
          height: 35,
          )
        )
      ],
    );
  }
}
