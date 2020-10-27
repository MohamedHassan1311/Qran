import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/Controller/Network/DP/azkar_joson.dart';
import 'package:quran/Models/azkar_model.dart';

import '../../constans.dart';
import '../drawer.dart';
import 'componets/container_with_counter.dart';
import 'componets/zekre_read_containr.dart';

class ReadDoaa extends StatefulWidget {
  static String id = "ReadDoaa";

  @override
  _ReadDoaaState createState() => _ReadDoaaState();
}

class _ReadDoaaState extends State<ReadDoaa> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        allowFontScaling: true);
    final height = ScreenUtil().screenHeight;
    final width = ScreenUtil().screenHeight;
    List<Azkar> azkarElMasaa = [];
    for (var data in azkarJoson) {
      Azkar azkara = Azkar.fromJson(data);
      if (azkara.category == azkartype) {
        azkarElMasaa.add(Azkar(
          category: azkara.category,
          zekr: azkara.zekr,
          count: azkara.count,
          description: azkara.description,
          reference: azkara.reference,
        ));
      }
    }
    PageController controller =
        PageController(viewportFraction: 1, keepPage: true);
    var currentPageValue = 0.0;
    var mItemCount = 10;
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      controller.addListener(() {
        setState(() {
          currentPageValue = controller.page;
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) => IconButton(
              color: Theme.of(context).accentColor,
              icon: SvgPicture.asset("assets/icons/menu.svg"),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
        title: Text("${azkartype}"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/bGImg.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: PageView.builder(
            onPageChanged: (int) {
              setState(() {
                count = 0;
              });
            },
            controller: controller,
            itemCount: azkarElMasaa.length,
            itemBuilder: (BuildContext context, int index) {
              print(index);
              return Column(
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: AekreReadContainr(
                      description: azkarElMasaa[index].description,
                      zekr: azkarElMasaa[index].zekr,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: ContainerWithCounter(
                        zekreCount: azkarElMasaa[index].count,
                        count: count,
                        azkarElMasaa_length: azkarElMasaa.length,
                        index: index,
                        ontap: () {
                          if (count == int.parse(azkarElMasaa[index].count)) {
                            count;
                            controller.jumpToPage(index + 1);

                            count = -1;
                          }
                          setState(() {
                            if (int.parse(azkarElMasaa[index].count) >= count) {
                              count++;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      endDrawer: Builder(
        builder: (context) {
          return buildDrawer(context);
        },
      ),
    );
  }
}
