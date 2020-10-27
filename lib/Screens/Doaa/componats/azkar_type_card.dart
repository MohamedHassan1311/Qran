import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../../constans.dart';

class AzkarTypeCard extends StatelessWidget {
  var txt;
  var photopath;
  Function ontap;
  AzkarTypeCard({this.txt, this.photopath, this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: ScreenUtil().screenWidth * .5,
        height: ScreenUtil().screenWidth * .5,
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                width: ScreenUtil().screenWidth * .30,
                height: ScreenUtil().screenWidth * .35,
                padding: EdgeInsets.only(left: kDefaultPadding + 12),
                margin: EdgeInsets.all(kDefaultPadding),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).accentColor.withOpacity(.9),
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
                child: Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding - 10),
                  child: AutoSizeText(
                    "${txt}",
                    textDirection: TextDirection.rtl,
                    style: Theme.of(context).textTheme.headline3.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: -12,
              top: 0,
              child: Container(
                  width: (ScreenUtil().screenWidth * .4) / 1.5,
                  height: (ScreenUtil().screenHeight * .2) / 1.5,
                  child: Image.asset(
                    "assets/image/doaaa.png",
                    fit: BoxFit.contain,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
