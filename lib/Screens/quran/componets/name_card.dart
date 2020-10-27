import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../../constans.dart';

class NameCard extends StatelessWidget {
  var photopath;
  Function ontap;
  String name, englishNameTranslation;
  NameCard(
      {this.name, this.englishNameTranslation, this.photopath, this.ontap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: ScreenUtil().screenHeight * .15,
        padding: EdgeInsets.only(
          left: kDefaultPadding - 10,
          right: kDefaultPadding - 10,
        ),
        margin: EdgeInsets.all(
          3.5,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(.5),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(200),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topLeft,
                child: Image(
                  image: AssetImage(photopath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(kDefaultPadding - 15),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: AutoSizeText(
                          name,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: kDefaultPadding + 5),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: AutoSizeText(
                          englishNameTranslation,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
