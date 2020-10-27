import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:quran/Controller/provider/counter.dart';
import 'package:quran/Controller/provider/taspihTextProvider.dart';

import '../../constans.dart';
import '../drawer.dart';

class SphaaScreen extends StatefulWidget {
  static final id = "SphaaScreen";
  const SphaaScreen({Key key}) : super(key: key);

  @override
  _SphaaScreenState createState() => _SphaaScreenState();
}

class _SphaaScreenState extends State<SphaaScreen> {
  @override
  void initState() {
    super.initState();
  }

  FocusNode f1 = FocusNode();
  @override
  Widget build(BuildContext context) {
    var textProvidar = Provider.of<TaspihTextProvider>(context, listen: false);
    var countProvider = Provider.of<counter>(context);
    TextEditingController controller = new TextEditingController();
    ScreenUtil.init(context,
        designSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        allowFontScaling: true);
    final height = ScreenUtil().screenHeight;
    final width = ScreenUtil().screenHeight;

    textProvidar.getDate();
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("سبحة"),
          centerTitle: true,
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) => IconButton(
                color: Theme.of(context).accentColor,
                icon: SvgPicture.asset("assets/icons/menu.svg"),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ],
        ),
        body: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/image/bGImg.jpg',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Card(
            color: Theme.of(context).primaryColor.withOpacity(.2),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      countProvider.incrementCounter();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: height,
                      width: width,
                      child: Text(countProvider.count.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ),
                textContainer(
                    width: width,
                    context: context,
                    onTap: () {
                      chooseDoaa(context, textProvidar, controller);
                    }),
                Container(
                    alignment: Alignment.bottomCenter,
                    width: width,
                    child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        icon: SvgPicture.asset(
                          "assets/icons/repeat.svg",
                          fit: BoxFit.contain,
                          color: Colors.red,
                        ),
                        label: AutoSizeText(
                          "اعاده",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontSize: 15),
                        ),
                        color: Theme.of(context).accentColor.withOpacity(.5),
                        onPressed: () {
                          countProvider.RestCounter();
                        })),
              ],
            ),
          ),
        ),
        endDrawer: Builder(
          builder: (context) {
            return buildDrawer(context);
          },
        ));
  }

  void chooseDoaa(BuildContext context, TaspihTextProvider textProvidar,
      TextEditingController controller) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: Theme.of(context).primaryColor.withOpacity(.9),
            title: Align(
              alignment: Alignment.center,
              child: Text(
                "اختار الدعاء",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            content: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              alignment: Alignment.center,
              child: Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: textProvidar.doaatext.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          height: ScreenUtil().setHeight(100),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: AutoSizeText(
                                      "${textProvidar.doaatext[index]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: IconButton(
                                                icon: SvgPicture.asset(
                                                  "assets/icons/add.svg",
                                                  color: Colors.white,
                                                  fit: BoxFit.fill,
                                                ),
                                                onPressed: () {
                                                  textProvidar.editText(
                                                      Txt: textProvidar
                                                          .doaatext[index]);
                                                  ShowToset("الأختيار ");
                                                  Navigator.of(context).pop();
                                                }),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: IconButton(
                                                icon: SvgPicture.asset(
                                                  "assets/icons/clearSearch.svg",
                                                  color: Colors.redAccent,
                                                ),
                                                onPressed: () {
                                                  textProvidar.deletDoaa(
                                                      index: index);
                                                  ShowToset("الحذف");
                                                  // Future.delayed(
                                                  //     Duration(milliseconds: 800),
                                                  //     () {
                                                  //   Navigator.of(context).pop();
                                                  // });
                                                }),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              Divider(
                                color: Theme.of(context).accentColor,
                                height: 5,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
            actions: <Widget>[
              RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.green,
                  icon: SvgPicture.asset(
                    "assets/icons/add.svg",
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                  label: Text(
                    "اضافة",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();

                    addDoaaDialogg(context, controller);
                  }),
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.red,
                icon: SvgPicture.asset(
                  "assets/icons/clearSearch.svg",
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
                label: Text(
                  " خروج",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white,
                      ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void addDoaaDialogg(BuildContext context, TextEditingController controller) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          var textProvidar =
              Provider.of<TaspihTextProvider>(context, listen: false);
          return AlertDialog(

            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: Theme.of(context).primaryColor.withOpacity(.6),
            title: Align(
              alignment: Alignment.center,
              child: Text(
                "اضافة دعاء",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            content: Container(
              width: double.maxFinite,
              child: TextField(
                focusNode: f1,
                autofocus: true,
                autocorrect: false,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.white),
                controller: controller,
                showCursor: true,
                cursorRadius: Radius.circular(30),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: Colors.white54,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusColor: Colors.white54,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            actions: [
              RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.green,
                  icon: SvgPicture.asset(
                    "assets/icons/add.svg",
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                  label: Text(
                    "اضافة",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  onPressed: () {
                    textProvidar.editText(Txt: controller.text);
                    f1.unfocus();
                    ShowToset("الاضافة");

                    setState(() {
                      textProvidar.addDoaa(Doaa: controller.text, vlue: true);
                    });

                    Future.delayed(Duration(microseconds: 600), () {
                      Navigator.of(context).pop();
                    });
                  }),
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.red,
                icon: SvgPicture.asset(
                  "assets/icons/clearSearch.svg",
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
                label: Text(
                  " خروج",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white,
                      ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Align textContainer({double width, BuildContext context, onTap}) {
    return Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(kDefaultPadding),
          height: ScreenUtil().setHeight(80),
          width: width,
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(.4),
              borderRadius: BorderRadius.circular(30)),
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 25),
              child: AutoSizeText(
                "${Provider.of<TaspihTextProvider>(
                  context,
                ).TextinField}",
                style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Colors.white,
                      textBaseline: TextBaseline.ideographic,
                    ),
              )),
        ),
      ),
    );
  }

  ShowToset(txt) {
    return showToast('تم $txt بنجاح ',
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
}
