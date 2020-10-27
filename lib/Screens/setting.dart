import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quran/Animation/animating_route.dart';
import 'package:quran/Controller/provider/Author.dart';
import 'package:quran/Controller/provider/audio_time.dart';
import 'package:quran/Controller/provider/text_size.dart';
import 'package:quran/Screens/home/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constans.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  AudioPlayer audioPlayer = AudioPlayer();


  Future<bool> _onWillPop() async {
     return (await Navigator.pushNamed(context, HomeScreen.id)) ?? true;
  }
  @override
  Widget build(BuildContext context) {
    var audioSwitcher = Provider.of<AudioTimeProvid>(
      context,
    );
    final author = Provider.of<Author>(context, listen: false);
    bool play = false;
    audioSwitcher.getDate();
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("ccc"),
        // ),
        body: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/image/bGImg.jpg'),
        fit: BoxFit.fill,
      ),
    ),
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor.withOpacity(.4),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              height: ScreenUtil().setHeight(90),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(colors: [
                                    Colors.white,
                                    Colors.white
                                  ])),
                              child: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).accentColor,
                                backgroundImage:
                                    AssetImage("assets/image/logo.png"),
                                radius: 40,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            _buildDivider(context),
                            buildExpansionTile(context, play, author),
                            SizedBox(height: 5.0),
                            _buildDivider(context),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "تشغيل تلقائي",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5.copyWith(color: Colors.white),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Switch(
                                        onChanged: (bool x) {
                                          audioSwitcher.canangeAutoPlay(
                                              AutoPlay: x);
                                        },
                                        value: audioSwitcher.autoplay,
                                        activeColor: Colors.green,
                                        inactiveTrackColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildDivider(context),
                            _texRow(context),
                          ],
                        ),
                      ),
                    ),
                    contactRow(context)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
        ),
      );
  }

  Padding contactRow(BuildContext context) {
    return Padding(
                        padding: const EdgeInsets.all(kDefaultPadding + 20),
                        child: Column(
                          children: [
                            Text(
                              "تواصل معنا",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: Colors.white),
                            ),
                            SizedBox(height: 15.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _launchURL(
                                        "https://www.facebook.com/profile.php?id=100006101352537");
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/icons8-facebook.svg",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _launchURL(
                                        "mailto:mohamedelbaz1311@gmail.com");
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/icons8-gmail.svg",
                                      fit: BoxFit.contain),
                                ),
                                InkWell(
                                  onTap: () {
                                    _launchURL(
                                        "https://wa.me/qr/REZYD2WRDNLOH1");
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/icons8-whatsapp.svg",
                                      fit: BoxFit.contain),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
  }

  _launchURL(url) async {
    // const url = 'https://www.facebook.com/profile.php?id=100006101352537';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Padding _texRow(
    BuildContext context,
  ) {
    var textsizePro = Provider.of<TextSizeProvider>(
      context,
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "تعديل حجم الخط",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontSize:  textsizePro.text_size),
            ),
          ),
          Expanded(
            child: Slider(
                activeColor: Colors.grey,
                inactiveColor: Colors.white,
                min: 20,
                max: 50,
                divisions: 5,
                label: " ${textsizePro.text_size}",
                value: textsizePro.text_size,
                onChanged: (double value) {
                  textsizePro.cangeTextSize(newvalue: value);
                }),
          ),
        ],
      ),
    );
  }

  Widget buildExpansionTile(BuildContext context, bool play, Author author) {
    return ExpansionTile(

      title: AutoSizeText(
        "تعديل صوت القاريء",
        style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
      ),
      children: <Widget>[
        buildNameRow(
          play: play,
          name: "محمد صديق المنشاوي",
          soundLink: "https://cdn.alquran.cloud/media/audio/ayah/ar.minshawi/8",
          authorName: "minshawi",
          ontap: () {
            author.changeAuthor("minshawi");

            ShowToset(context);
            audioPlayer.stop();
          },
        ),
        buildNameRow(
          play: play,
          name: "عبد الباسط عبد الصمد",
          soundLink:
              "https://cdn.alquran.cloud/media/audio/ayah/ar.abdulbasitmurattal/8",
          authorName: "abdulbasitmurattal",
          ontap: () {
            author.changeAuthor("abdulbasitmurattal");
            ShowToset(context);
            audioPlayer.stop();
          },
        ),
        buildNameRow(
          play: play,
          name: "عبدالرحمن السديس",
          soundLink:
              "https://cdn.alquran.cloud/media/audio/ayah/ar.abdurrahmaansudais/8",
          authorName: "abdurrahmaansudais",
          ontap: () {
            author.changeAuthor("abdurrahmaansudais");
            ShowToset(context);
            audioPlayer.stop();
          },
        ),
        buildNameRow(
          play: play,
          name: "مشاري العفاسي",
          soundLink: "https://cdn.alquran.cloud/media/audio/ayah/ar.alafasy/8",
          authorName: "alafasy",
          ontap: () {
            author.changeAuthor("alafasy");
            ShowToset(context);
            audioPlayer.stop();
          },
        ),
        buildNameRow(
            play: play,
            name: "محمود خليل الحصري",
            soundLink: "https://cdn.alquran.cloud/media/audio/ayah/ar.husary/8",
            authorName: "husary",
            ontap: () {
              author.changeAuthor("husary");

              ShowToset(context);
              audioPlayer.stop();
            }),
        buildNameRow(
            play: play,
            name: "ماهر المعيقلي",
            soundLink:
                "https://cdn.alquran.cloud/media/audio/ayah/ar.mahermuaiqly/8",
            authorName: "mahermuaiqly",
            ontap: () {
              author.changeAuthor("mahermuaiqly");
              ShowToset(context);
              audioPlayer.stop();
            }),
        buildNameRow(
            play: play,
            name: "محمد جبريل",
            soundLink:
                "https://cdn.alquran.cloud/media/audio/ayah/ar.muhammadjibreel/8",
            authorName: "muhammadjibreel",
            ontap: () {
              author.changeAuthor("muhammadjibreel");
              ShowToset(context);
              audioPlayer.stop();
            }),
      ],
    );
  }

  Divider _buildDivider(context) {
    return Divider(
      height: 40,
      thickness: 2,
      indent: 10,
      endIndent: 10,
      color: Theme.of(context).accentColor,
    );
  }

  ShowToset(context) {
    return showToast('تم الأختيار بنجاح ',
        dismissOtherToast: true,
        context: context,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideToTop,
        position: StyledToastPosition.top,
        startOffset: Offset(0.0, -3.0),
        reverseEndOffset: Offset(0.0, -3.0),
        duration: Duration(seconds: 2),
        borderRadius: BorderRadius.circular(30),
        backgroundColor: Colors.green,
        //Animation duration   animDuration * 2 <= duration
        animDuration: Duration(seconds: 1),
        curve: Curves.elasticOut,
        reverseCurve: Curves.fastOutSlowIn);
  }

  buildNameRow({play, name, soundLink, authorName, ontap, isPlaying}) {
    return ListTile(
      title: AutoSizeText(
        "$name",
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: Container(
        width: ScreenUtil().setWidth(140),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/play.svg",
                color: Colors.white,
              ),
              color: Theme.of(context).accentColor.withOpacity(.3),
              onPressed: () async {
                await audioPlayer.play(soundLink);
              },
            )),
            Expanded(
                flex: 2,
                child: RaisedButton.icon(
                    onPressed: ontap,
                    color: Colors.green,
                    icon: SvgPicture.asset(
                      "assets/icons/Items.svg",
                      color: Colors.white,
                      fit: BoxFit.contain,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    label: AutoSizeText(
                      "أختيار",
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ),
      ),
    );
  }
}
