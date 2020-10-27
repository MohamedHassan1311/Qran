import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/Animation/animating_route.dart';
import 'package:quran/Screens/Doaa/doaa_home_screen.dart';
import 'package:quran/Screens/drawer.dart';
import 'package:quran/Screens/quran/quran_screen.dart';
import 'package:quran/Screens/read_zekr/read_doaa.dart';
import 'package:quran/Screens/taspehh/sphaa_screen.dart';

import '../../constans.dart';
import '../../network_senstev.dart';
import 'componets/card_with_text.dart';
import 'componets/heder_containr.dart';

class HomeScreen extends StatefulWidget {
  static String id = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        allowFontScaling: true);
    final height = ScreenUtil().screenHeight;
    final width = ScreenUtil().screenHeight;

    return Scaffold(
      appBar: buildAppBar(context),
      body: NetworkSensitive(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/bGImg.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Card(
            color: Theme.of(context).primaryColor.withOpacity(.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: HeaderContainr(
                      text: "s",
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CardWithText(
                        txt: "قراءة",
                        photopath: ("assets/image/read.png"),
                        ontap: () {

                           Navigator.of(context).push(
                          AnimatingRoute(Screen: Quran_screen()),);
                        
                        },
                      ),
                      CardWithText(
                        txt: "سبحة",
                        photopath: ("assets/image/salah.png"),
                        ontap: () {
                            Navigator.push(context,
                          AnimatingRoute(Screen: SphaaScreen()));
                          
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CardWithText(
                        txt: "دعاء",
                        photopath: ("assets/image/doaaa.png"),
                        ontap: () {
                          Navigator.push(context,
                          AnimatingRoute(Screen: Doaaa()), );
                         
                        },
                      ),
                      CardWithText(
                        txt: "ختمه الصلاه",
                        photopath: ("assets/image/ktma.png"),
                        ontap: () {
                          azkartype = "اذكار الصلاة";
                          Navigator.push(context,
                          AnimatingRoute(Screen: ReadDoaa()), );
                         
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      endDrawer: Builder(
        builder: (context) {
          return buildDrawer(context);
        },
      ),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
           automaticallyImplyLeading: false,
      elevation: 0,
      title: Text("الصفحة الرئسية"),
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
    );
  }
}
