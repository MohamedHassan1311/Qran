import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:quran/Controller/Network/quran_api_service.dart';
import 'package:quran/Models/date_model.dart';

import '../../../constans.dart';

class HeaderContainr extends StatelessWidget {
  Function ontap;

  String text;
  HeaderContainr({this.ontap, this.text});
  String date;
  String format;
  String day;
  String weekday;
  String month;
  String year;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenHeight * .25,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(.3),
        // color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            height: ScreenUtil().screenHeight * .25,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(.3),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: FutureBuilder<Date>(
                      future: QuranAPI().getDate(),
                      builder: (context, getSnap) {
                        if (getSnap.hasData) {
                          return Padding(
                            padding: const EdgeInsets.all(kDefaultPadding),
                            child: Column(
                              textDirection: TextDirection.rtl,


                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: AutoSizeText(
                                      "اليوم"
                                      " "
                                      ":"
                                      " "
                                      "${getSnap.data.data.hijri.weekday.ar}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: AutoSizeText(
                                        "الشهر"
                                        " "
                                        ":"
                                        " "
                                        "${getSnap.data.data.hijri.month.ar}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: AutoSizeText(
                                        "التاريخ الهجري"
                                        " "
                                        ":"
                                        " "
                                        "${getSnap.data.data.hijri.date}",
                                        style:
                                            Theme.of(context).textTheme.headline6,
                                      ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            child: Center(
                              child: JumpingText(
                                '....',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          );
                        }
                      }),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      shape: BoxShape.circle,
                    ),
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/image/salah.png"),
                    ),
                    // height: ScreenUtil().setHeight(100),
                  ),
                )
              ],
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     margin: EdgeInsets.only(
          //         left: kDefaultPadding, right: kDefaultPadding),
          //     child: RaisedButton(
          //         color: Theme.of(context).accentColor,
          //         focusNode: FocusNode(canRequestFocus: false),
          //         onPressed: () {
          //           Navigator.push(
          //               context, AnimatingRoute(Screen: SearchScreen()));
          //         },
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(30)),
          //         child: Row(
          //           children: [
          //             Expanded(child: Text("بحث")),
          //             SvgPicture.asset(
          //               "assets/icons/search.svg",
          //               color: Colors.black,
          //             ),
          //           ],
          //         )),
          //   ),
          // ),
        ],
      ),
    );
  }
}
