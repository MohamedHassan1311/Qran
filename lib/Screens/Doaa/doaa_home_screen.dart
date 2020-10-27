import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/Animation/animating_route.dart';
import 'package:quran/Screens/drawer.dart';
import 'package:quran/constans.dart';

import '../read_zekr/read_doaa.dart';
import 'componats/azkar_type_card.dart';

class Doaaa extends StatefulWidget {
  static String id = "Doaaa";

  @override
  _DoaaaState createState() => _DoaaaState();
}

class _DoaaaState extends State<Doaaa> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        allowFontScaling: true);
    final height = ScreenUtil().screenHeight;
    final width = ScreenUtil().screenHeight;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("دعاء"),
          centerTitle: true,
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) => IconButton(
                color: Theme.of(context).accentColor,
                icon: SvgPicture.asset("assets/icons/menu.svg"),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ],
        ),
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.9),
            image: DecorationImage(
              image: AssetImage('assets/image/bGImg.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      AzkarTypeCard(
                        txt: "اذكار الصباح",
                        ontap: () {
                          azkartype = "أذكار الصباح";
                          Navigator.push(
                              context, AnimatingRoute(Screen: ReadDoaa()));
                        },
                      ),
                      AzkarTypeCard(
                        txt: "اذكار المساء",
                        ontap: () {
                          azkartype = "أذكار المساء";
                          Navigator.push(
                              context, AnimatingRoute(Screen: ReadDoaa()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  AzkarTypeCard(
                    txt: "أذكار الاستيقاظ من النوم",
                    ontap: () {
                      azkartype = "أذكار الاستيقاظ من النوم";
                      Navigator.push(
                          context, AnimatingRoute(Screen: ReadDoaa()));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        endDrawer: Builder(
          builder: (context) {
            return buildDrawer(context);
          },
        ));
  }
}
