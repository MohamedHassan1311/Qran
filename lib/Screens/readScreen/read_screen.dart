import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:quran/Controller/provider/audio_time.dart';
import 'package:quran/Controller/provider/text_size.dart';

import '../../constans.dart';
import '../../network_senstev.dart';
import '../drawer.dart';
import 'componets/number_card.dart';

class ReadingScreen extends StatefulWidget {
  static String id = "ReadingScreen";

  @override
  _ReadingScreenState createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  int index = 0;
  int initindex;
  double hight;
  double inithight;
  bool txtcontairrsize = false;
  bool listen = false;
  bool play = false;
  String curantTime = "0:0";
  String fullTime = "0:0";
  var full;
  ScrollController controller = ScrollController();
  AudioPlayer audioPlayer = AudioPlayer();
  bool showsideClumn = false;
  List<String> TextData;
  String viewText;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var textsizePro = Provider.of<TextSizeProvider>(
      context,
    );
    ScreenUtil.init(context,
        designSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        allowFontScaling: true);
    final height = ScreenUtil().screenHeight;
    final width = ScreenUtil().screenHeight;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                txtcontairrsize = true;
              });
            }),
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) => IconButton(
              color: Theme.of(context).accentColor,
              icon: SvgPicture.asset("assets/icons/menu.svg"),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
        title: Text("${souraName}"),
        centerTitle: true,
      ),
      body: NetworkSensitive(opacity: .5,
        child: Stack(
          children: <Widget>[
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/bGImg.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                width: width,
                height: height,
                child: Column(
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          showsideClumn == true
                              ? Expanded(
                                  flex: 1,
                                  child: infoRow(context),
                                )
                              : Container(),
                          //read
                          Expanded(
                            flex: 5,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: height,
                                width: width,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.5),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 10),
                                        blurRadius: 60,
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(.40),
                                      )
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: ayah.length,
                                        itemBuilder: (context, inde) {
                                          return GestureDetector(
                                            onTap: () async {
                                              if (showsideClumn == false) {
                                                setState(() {
                                                  showsideClumn = true;
                                                  index = inde;
                                                });
                                              } else {
                                                setState(() {
                                                  showsideClumn = false;
                                                });
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceAround,
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Text(
                                                    "${ayah[inde].text.replaceAll("بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ ", " ﴿ بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ ﴾ُ\n ")}" +
                                                        "﴿${ayah[inde].numberInSurah}﴾ُ ",
                                                    textAlign:
                                                        TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize:
                                                            textsizePro
                                                                .text_size,
                                                        color:
                                                            Colors.white),
                                                    textDirection:
                                                        TextDirection.rtl,
                                                  ),
                                                ),
                                                IconButton(
                                                    icon: SvgPicture.asset(
                                                      "assets/icons/sound.svg",
                                                      color: Colors.white,
                                                      allowDrawingOutsideViewBox:
                                                          true,
                                                      matchTextDirection:
                                                          true,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        index = inde;
                                                        listen = true;
                                                      });
                                                    })
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            listen == true
                ? ListenCard(height, width, context, textsizePro)
                : Container(),
            txtcontairrsize
                ? resizeText(height, width, context, textsizePro)
                : Container(
                    width: 0,
                    height: 0,
                  ),
          ],
        ),
      ),
      endDrawer: Builder(
        builder: (context) {
          return buildDrawer(context);
        },
      ),
    );
  }
  




  Padding infoRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          NumberCard(
            numo: true,
            Txt: "الايات",
            num: ayah.length,
          ),
          NumberCard(
            numo: true,
            Txt: "الحزب",
            num: ayah[index].hizbQuarter,
          ),
          NumberCard(
            numo: true,
            Txt: "الجزء",
            num: ayah[index].juz,
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(10), horizontal: 1),
            padding: EdgeInsets.all(2),
            width: ScreenUtil().setWidth(90),
            height: ScreenUtil().setHeight(60),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                shape: BoxShape.rectangle,
                color: Theme.of(context).primaryColor.withOpacity(.8),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(20, 15),
                      blurRadius: 30,
                      color: Theme.of(context).accentColor.withOpacity(.5)),
                  BoxShadow(
                      offset: Offset(-15, -15),
                      blurRadius: 30,
                      color: Theme.of(context).accentColor.withOpacity(.5))
                ]),
            child: Column(
              children: [
                IconButton(
                    tooltip: "تشغيل",
                    icon: SvgPicture.asset(
                      "assets/icons/sound.svg",
                      color: Colors.white,
                      semanticsLabel: "تشغيل",
                      allowDrawingOutsideViewBox: true,
                      matchTextDirection: true,
                    ),
                    onPressed: () {
                      setState(() {
                        listen = true;
                      });
                    }),
              ],
            ),
          ),
          Spacer(),
          NumberCard(
            numo: true,
            Txt: "الصفحه",
            num: ayah[index].page,
          )
        ],
      ),
    );
  }

  Align resizeText(
      double height, double width, BuildContext context, textsizePro) {
         var audioSwitcher = Provider.of<AudioTimeProvid>(
      context,
    );
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: height * .20,
        width: width,
        margin: EdgeInsets.only(
            top: 10,
            right: kDefaultPadding - 10,
            bottom: 20,
            left: kDefaultPadding - 10),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.8),
            borderRadius: BorderRadius.all(
              Radius.circular(70),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 60,
                color: Theme.of(context).accentColor.withOpacity(.40),
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: AutoSizeText(
                "تعديل حجم الخط",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white),
              )),
              Expanded(
                child: Slider(
                    activeColor: Colors.grey,
                    inactiveColor: Colors.white,
                    min: 20,
                    max: 50,
                    divisions: 10,
                    label: " ${textsizePro.text_size}",
                    value: textsizePro.text_size,
                    onChanged: (double value) {
                      textsizePro.cangeTextSize(newvalue: value);
                    }),
              ),

              Expanded(
                child: RaisedButton(
                    child: Text("انهاء"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.grey,
                    onPressed: () {
                      setState(() {
                        txtcontairrsize = false;
                      });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Align ListenCard(
      double height, double width, BuildContext context, textsizePro) {
    var timeProvider = Provider.of<AudioTimeProvid>(context, listen: true);
    timeProvider.getDate();
    audioPlayer.onAudioPositionChanged.listen((Duration sacond) {
      timeProvider.changeCurentTime(curentime: sacond.toString().split(".")[0]);
    });
    audioPlayer.onDurationChanged.listen((Duration sacond) {
      timeProvider.chaneFullTime(Fulltime: sacond.toString().split(".")[0]);
    });
    var currentPageValue = 0.0;
    PageController controller =
        PageController(viewportFraction: 1, keepPage: true, initialPage: index);
    var audioSwitcher = Provider.of<AudioTimeProvid>(
      context,
    );
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: height * .5,
        width: width,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(right: 5, left: 5),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.8),
            borderRadius: BorderRadius.circular(40)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      icon: SvgPicture.asset(
                        "assets/icons/exit.svg",
                        color: Colors.white,
                      ),
                      label: AutoSizeText(
                        "خروج",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontSize: 15),
                      ),
                      color: Colors.red.withOpacity(.8),
                      onPressed: () {
                        audioPlayer.stop();
                        timeProvider.caneAudioStatus(Play: false);
                        timeProvider.chaneFullTime(Fulltime: "0.0");
                        timeProvider.changeCurentTime(curentime: "0.0");
                        setState(() {
                          listen = false;
                        });
                      }),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: PageView.builder(
                  itemCount: ayah.length,
                  controller: controller,
                  itemBuilder: (context, pageindex) {
                    audioSwitcher.autoplay == true
                        ? audioPlayer.onPlayerCompletion.listen((event) {
                          timeProvider.caneAudioStatus(Play: true);
                            timeProvider.chaneFullTime(Fulltime: "0.0");
                            timeProvider.changeCurentTime(curentime: "0.0");


                            if (!controller.hasClients) return false;
                            if (pageindex <= ayah.length) {
                              pageindex++;
                              controller.jumpToPage(pageindex);
                              audioPlayer.play(ayah[pageindex].audio);
                            }
                          })
                        : audioPlayer.onPlayerCompletion.listen((event) {

                          timeProvider.caneAudioStatus(
                                              Play: false);
                        });
                    return Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: kDefaultPadding - 10),
                            alignment: Alignment.center,
                            child: SizedBox(
                              child: AutoSizeText(
                                "${ayah[pageindex].text.replaceAll("بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ ", " ﴿ بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ ﴾ُ\n ")}" +
                                    "﴿${ayah[pageindex].numberInSurah}﴾ُ ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: textsizePro.text_size,
                                    color: Colors.white),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RaisedButton.icon(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    icon: SvgPicture.asset(
                                      "assets/icons/repeat.svg",
                                      fit: BoxFit.contain,
                                      color: Colors.white,
                                    ),
                                    label: AutoSizeText(
                                      "اعاده",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(fontSize: 15),
                                    ),
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(.3),
                                    onPressed: () {
                                      audioPlayer.release();
                                      timeProvider.caneAudioStatus(Play: false);
                                      setState(() {
                                        curantTime = "0:0";
                                        // play = false;
                                      });
                                    }),
                                timeProvider.play == true
                                    ? RaisedButton.icon(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        icon: SvgPicture.asset(
                                          "assets/icons/puse.svg",
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          "ايقاف",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(fontSize: 15),
                                        ),
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(.3),
                                        onPressed: () {
                                          audioPlayer.pause();
                                          timeProvider.caneAudioStatus(
                                              Play: false);
                                          // setState(() {
                                          //   play = false;
                                          // });
                                        })
                                    : RaisedButton.icon(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        icon: SvgPicture.asset(
                                          "assets/icons/play.svg",
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          "تشغيل",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(fontSize: 15),
                                        ),
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(.3),
                                        onPressed: () async {
                                          timeProvider.caneAudioStatus(
                                              Play: true);

                                          await audioPlayer.play(
                                              ayah[pageindex].audio,
                                              stayAwake: true);
                                          if (timeProvider.changeCurentTime() ==
                                              timeProvider.fullTime) {
                                            timeProvider.caneAudioStatus(
                                                Play: false);
                                            timeProvider.chaneFullTime(
                                                Fulltime: "0.0");
                                            timeProvider.changeCurentTime(
                                                curentime: "0.0");
                                          }
                                        }),
                                FittedBox(
                                  child: AutoSizeText(
                                    timeProvider.CurentTime != null
                                        ? "${timeProvider.CurentTime}"
                                        : "جاري التحميل",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                AutoSizeText(
                                  "|",
                                  style: TextStyle(color: Colors.white),
                                ),
                                FittedBox(
                                  child: AutoSizeText(
                                    "${timeProvider.fullTime}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
// child: ExpansionTile(
// initiallyExpanded: listen,
// trailing: IconButton(
// tooltip: "تشغيل",
// icon: SvgPicture.asset(
// "assets/icons/sound.svg",
// color: Colors.white,
// semanticsLabel: "تشغيل",
// allowDrawingOutsideViewBox:
// true,
// matchTextDirection: true,
// ),
// onPressed: () {
// setState(() {
// listen = true;
// });
// }),
// title: Container(
// margin: EdgeInsets.symmetric(
// vertical: kDefaultPadding - 10),
// alignment: Alignment.center,
// child: SizedBox(
// height: hight,
// child: AutoSizeText(
// "${ayah[inde].text.replaceAll("بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ ", " ﴿ بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ ﴾ُ\n ")}" +
// "﴿${ayah[inde].numberInSurah}﴾ُ ",
// textAlign: TextAlign.center,
// style: TextStyle(
// fontSize: txtize,
// color: Colors.white),
// textDirection:
// TextDirection.rtl,
// ),
// ),
// ),
// children: [
// Row(
// crossAxisAlignment:
// CrossAxisAlignment.center,
// mainAxisAlignment:
// MainAxisAlignment.spaceAround,
// children: [
// RaisedButton.icon(
// shape: RoundedRectangleBorder(
// borderRadius:
// BorderRadius
//     .circular(50)),
// icon: SvgPicture.asset(
// "assets/icons/stop.svg",
// color: Colors.white,
// ),
// label: Text(
// "ايقاف",
// style: Theme.of(context)
// .textTheme
//     .headline6,
// ),
// color: Theme.of(context)
// .primaryColor
//     .withOpacity(.1),
// onPressed: () {
// audioPlayer.pause();
// listen = false;
// }),
// RaisedButton.icon(
// shape: RoundedRectangleBorder(
// borderRadius:
// BorderRadius
//     .circular(50)),
// icon: SvgPicture.asset(
// "assets/icons/play.svg",
// color: Colors.white,
// ),
// label: Text(
// "تشغيل",
// style: Theme.of(context)
// .textTheme
//     .headline6,
// ),
// color: Theme.of(context)
// .primaryColor
//     .withOpacity(.1),
// onPressed: () {
// audioPlayer.play(
// ayah[inde].audio,
// stayAwake: false);
// }),
// Text(
// "$curantTime",
// style: Theme.of(context)
// .textTheme
//     .headline6,
// ),
// Text("|"),
// Text(
// "$fullTime",
// style: Theme.of(context)
// .textTheme
//     .headline6,
// )
// ],
// )
// ],
// ),
