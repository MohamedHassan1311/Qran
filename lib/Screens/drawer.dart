import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/Animation/animating_route.dart';
import 'package:quran/Screens/quran/quran_screen.dart';
import 'package:quran/Screens/read_zekr/read_doaa.dart';
import 'package:quran/Screens/setting.dart';

import '../constans.dart';
import 'Doaa/doaa_home_screen.dart';
import 'home/home_screen.dart';

buildDrawer(context) {
  ScreenUtil.init(context,
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      allowFontScaling: true);
  return Theme(
    data: Theme.of(context).copyWith(
      canvasColor: Colors.transparent.withOpacity(.7),
    ),
    child: Drawer(
      child: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(90),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    backgroundImage: AssetImage("assets/image/logo.png"),
                    radius: 40,
                  ),
                ),
                SizedBox(height: 5.0),
                Text("Quran",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white,
                        )),
                SizedBox(height: 30.0),
                _buildRow(
                  context: context,
                  assetName: "assets/icons/Items.svg",
                  title: "الصفحة الرئسية",
                  ontap: () {
                    Navigator.pushAndRemoveUntil(context,
                        AnimatingRoute(Screen: HomeScreen()), (route) => false);
                  },
                ),
                _buildDivider(context),
                _buildRow(
                  context: context,
                  assetName: "assets/icons/Items.svg",
                  title: "قراءة",
                  ontap: () {
                    Navigator.push(
                        context, AnimatingRoute(Screen: Quran_screen()));
                  },
                ),
                _buildDivider(context),
                _buildRow(
                  context: context,
                  assetName: "assets/icons/Items.svg",
                  title: "ختمة صلاة",
                  ontap: () {
                    azkartype = "اذكار الصلاة";
                    Navigator.push(context, AnimatingRoute(Screen: ReadDoaa()));
                  },
                ),
                _buildDivider(context),
                _buildRow(
                  context: context,
                  assetName: "assets/icons/Items.svg",
                  title: "دعاء",
                  ontap: () {
                    Navigator.push(context, AnimatingRoute(Screen: Doaaa()));
                  },
                ),
                _buildDivider(context),
                _buildRow(
                  context: context,
                  assetName: "assets/icons/setting.svg",
                  title: "الاعدادت  ",
                  ontap: () {
                    Navigator.pop(context,true);
                    Navigator.push(
                        context, AnimatingRoute(Screen: SettingScreen()));
                    // Navigator.of(context).pushAndRemoveUntil(
                    //
                    //     AnimatingRoute(Screen: SettingScreen()),
                    //     ModalRoute.withName(HomeScreen.id));
                  },
                ),
                _buildDivider(context),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Divider _buildDivider(context) {
  return Divider(
    height: 20,
    thickness: .5,
    color: Theme.of(context).primaryColor,
  );
}

Widget _buildRow({context, IconData icon, String title, ontap, assetName}) {
  final TextStyle tStyle =
      Theme.of(context).textTheme.headline6.copyWith(color: Colors.white);
  return InkWell(
    onTap: ontap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          SvgPicture.asset(assetName),
          SizedBox(width: 10.0),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
        ],
      ),
    ),
  );
}
