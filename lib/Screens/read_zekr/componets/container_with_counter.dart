import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../../constans.dart';

class ContainerWithCounter extends StatelessWidget {
  String zekreCount;
  int count;
  int index;
  int azkarElMasaa_length;
  Function ontap;
  ContainerWithCounter(
      {this.count,
      this.index,
      this.ontap,
      this.azkarElMasaa_length,
      this.zekreCount});
  @override
  Widget build(BuildContext context) {
  ScreenUtil.init(context,designSize:Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) , 
        allowFontScaling: true); 
    final height = ScreenUtil().screenHeight;
    final width = ScreenUtil().screenHeight;
    return Container(
      width: width,
      margin: EdgeInsets.only(
          right: kDefaultPadding - 10,
          left: kDefaultPadding - 10,
          bottom: kDefaultPadding - 10),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(.5),
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
        padding: const EdgeInsets.only(
            right: kDefaultPadding,
            left: kDefaultPadding,
            bottom: kDefaultPadding - 10,
            top: kDefaultPadding - 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: AutoSizeText(
                "${zekreCount}" + "\n " + "عدد مرات الذكر",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
                child: FloatingActionButton(
              onPressed: ontap,
              child: Text("${count}"),
            )),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: AutoSizeText(
                  "${index + 1}" + "/" + "$azkarElMasaa_length",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
