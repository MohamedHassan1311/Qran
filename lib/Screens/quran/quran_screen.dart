import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:quran/Animation/animating_route.dart';
import 'package:quran/Controller/Network/quran_api_service.dart';
import 'package:quran/Controller/provider/Author.dart';
import 'package:quran/Controller/provider/qurandata.dart';
import 'package:quran/Models/soura_model.dart';
import 'package:quran/Screens/quran/componets/custom_aya_card.dart';
import 'package:quran/Screens/quran/componets/heder_withTextBox.dart';
import 'package:quran/Screens/readScreen/read_screen.dart';

import '../../constans.dart';
import '../../network_senstev.dart';
import '../drawer.dart';

class Quran_screen extends StatefulWidget {
  static String id = "Quran_screen";

  @override
  _Quran_screenState createState() => _Quran_screenState();
}

class _Quran_screenState extends State<Quran_screen> {
  QuranAPI api = QuranAPI();
  ScrollController controller = ScrollController();
  bool closeTopHeaderWithText = false;
  double topContainer = 0;
  Future _future;

  @override
  void initState() {
    super.initState();
    setState(() {
      String author =Provider.of<Author>(context,listen: false).author;
      _future =
          QuranAPI().getchapter(author: author != null ? author : "alafasy");
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    
    controller.addListener(() {
      double value = controller.offset /
          ScreenUtil().scaleHeight /
          (ScreenUtil().screenHeight * .15);

      setState(() {
        topContainer = value;
        closeTopHeaderWithText = controller.offset > 50;
      });
    });
    var provider = Provider.of<quranDataProvider>(context, listen: false);
    ScreenUtil.init(context,
        designSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        allowFontScaling: true);
    final height = ScreenUtil().screenHeight;
    final width = ScreenUtil().screenHeight;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("قراءة"),
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
          child: Column(
            children: <Widget>[
              AnimatedOpacity(
                duration: Duration(milliseconds: 600),
                opacity: closeTopHeaderWithText ? 0 : 1,
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: ScreenUtil().screenWidth,
                    height: closeTopHeaderWithText
                        ? 0
                        : ScreenUtil().screenHeight * .25,
                    alignment: Alignment.centerRight,
                    child: HeaderWithText(
                      ontap: () {},
                    )),
              ),
              Expanded(
                child: FutureBuilder<Surahh>(
                  future: _future,
                  builder: (context, snap) {
                    List<Surah> soura = [];

                    if (snap.hasData) {
                      for (var data in snap.data.data.surahs) {
                        soura.add(Surah(
                          name: data.name,
                          englishName: data.englishName,
                          number: data.number,
                          ayahs: data.ayahs,
                        ));
                      }
                      souraData = soura;
                      return Container(
                        child: ListView.builder(
                          controller: controller,
                          itemCount: soura.length,
                          itemBuilder: (context, index) {
                            double scale = 1.0;
                            if (topContainer > 0.5) {
                              scale = index + 0.5 - topContainer;
                              if (scale < 0) {
                                scale = 0;
                              } else if (scale > 1) {
                                scale = 1;
                              }
                            }
                            return Transform(
                              transform: Matrix4.identity()..scale(scale, scale),
                              alignment: Alignment.centerRight,
                              child: AyaCard(
                                name: soura[index].name,
                                englishNameTranslation: soura[index].englishName,
                                photopath: ("assets/image/read.png"),
                                ontap: () {
                                  Navigator.push(context,
                                      AnimatingRoute(Screen: ReadingScreen()));
                                  souraName = soura[index].name;
                                  ayah = soura[index].ayahs;
                                },
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: JumpingText(
                            '....',
                            style: Theme.of(context).textTheme.headline2.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
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
}
