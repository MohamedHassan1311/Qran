import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran/Animation/animating_route.dart';
import 'package:quran/Screens/quran/componets/shimmer_titel.dart';
import 'package:quran/Screens/search/search_screen.dart';

import '../../../constans.dart';

class HeaderWithText extends StatelessWidget {
  Function ontap;

  HeaderWithText({this.ontap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding - 15),
      height: ScreenUtil().screenHeight * .20,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: kDefaultPadding, right: kDefaultPadding, bottom: 40),
            height: ScreenUtil().screenHeight * .17,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                ShimmerTitle(
                  text: " بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيم",
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    shape: BoxShape.circle,
                  ),
                  child: Image(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/image/read.png"),
                  ),
                  // height: ScreenUtil().setHeight(100),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(
                  left: kDefaultPadding, right: kDefaultPadding),
              child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  focusNode: FocusNode(canRequestFocus: false),
                  onPressed: () {
                    Navigator.push(
                        context, AnimatingRoute(Screen: SearchScreen()));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      Expanded(child: Text("بحث")),
                      SvgPicture.asset(
                        "assets/icons/search1.svg",
                        color: Colors.black,
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
