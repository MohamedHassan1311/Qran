import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class NumberCard extends StatefulWidget {
  var Txt;
  var num;
  bool numo = true;
  NumberCard({this.Txt, this.num, this.numo});

  @override
  _NumberCardState createState() => _NumberCardState();
}

class _NumberCardState extends State<NumberCard> {
  @override
  Widget build(BuildContext context) {
  ScreenUtil.init(context,designSize:Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) , 
        allowFontScaling: true); 
    final height = ScreenUtil().screenHeight;
    final width = ScreenUtil().screenHeight;

    return Container(
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
      child: Align(
        alignment: Alignment.center,
        child: widget.numo == true
            ? Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(
                      "${widget.num}",
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FittedBox(
                      child: Text(
                        "${widget.Txt}",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        "${widget.Txt}",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
