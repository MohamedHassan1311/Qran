import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran/Controller/provider/text_size.dart';

import '../../../constans.dart';

class AekreReadContainr extends StatelessWidget {
  var description;
  var zekr;
  var reference;
  AekreReadContainr({this.description, this.zekr, this.reference});
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
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: width,
        margin: EdgeInsets.all(kDefaultPadding - 10),
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              description != ""
                  ? Container(
                      height: ScreenUtil().setHeight(height * .20 - 20),
                      width: width,
                      margin: EdgeInsets.only(
                          top: 10,
                          right: kDefaultPadding - 10,
                          left: kDefaultPadding - 10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(.2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(70),
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
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            description,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: textsizePro.text_size),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  AutoSizeText(
                                    zekr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: textsizePro.text_size),
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
