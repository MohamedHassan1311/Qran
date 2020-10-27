import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../../constans.dart';

class CardWithText extends StatelessWidget {
  var txt;
  var photopath;
  Function ontap;
  CardWithText({this.txt, this.photopath, this.ontap});
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        allowFontScaling: true);
    final height = ScreenUtil().screenHeight;
    final width = ScreenUtil().screenHeight;

    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: ScreenUtil().screenWidth * .4,
        height: ScreenUtil().screenHeight * .3,
        child: Stack(
          children: <Widget>[
            Container(
              width: ScreenUtil().screenWidth * .3,
              height: ScreenUtil().screenHeight * .16,
              // width: ScreenUtil().setWidth(220),
              // height: ScreenUtil().setHeight(220),
              margin: EdgeInsets.symmetric(
                  vertical: ScreenUtil().screenHeight * 0.05),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                  color: Theme.of(context).accentColor.withOpacity(.5),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(-15, 20),
                        blurRadius: 15,
                        color: Theme.of(context).accentColor.withOpacity(.1)),
                    BoxShadow(
                        offset: Offset(15, 20),
                        blurRadius: 15,
                        color: Theme.of(context).accentColor.withOpacity(.1))
                  ]),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Image(
                      image: AssetImage(photopath),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.only(right: kDefaultPadding),
                        child: AutoSizeText(
                          txt,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                color: Colors.white,
                              ),
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
    );
  }
}
