import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/Animation/animating_route.dart';
import 'package:quran/Models/soura_model.dart';
import 'package:quran/Screens/quran/componets/custom_aya_card.dart';
import 'package:quran/Screens/readScreen/read_screen.dart';

import '../../constans.dart';

class SearchScreen extends StatefulWidget {
  static String id = "SearchScreen";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final key = GlobalKey<ScaffoldState>();
  List<Surah> _searchResult = [];
  TextEditingController controller = new TextEditingController();
  FocusNode f1 = FocusNode();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        allowFontScaling: true);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/bGImg.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 10, right: 15, left: 15),
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      focusNode: f1,
                      autofocus: true,
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.right,
                      onChanged: onSearchTextChanged,
                      style: TextStyle(color: Colors.white),
                      controller: controller,
                      showCursor: true,
                      cursorRadius: Radius.circular(30),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: SvgPicture.asset(
                              "assets/icons/clearSearch.svg",
                              color: Colors.white,
                            ),
                            onPressed: () {
                              controller.clear();

                              setState(() {
                                _searchResult.clear();
                              });
                            }),
                        prefixIcon: Icon(
                          Icons.search,
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
                    )),
                _searchResult.length != 0 || controller.text.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: _searchResult.length,
                          itemBuilder: (context, index) {
                            return AyaCard(
                              name: _searchResult[index].name,
                              englishNameTranslation:
                                  _searchResult[index].englishName,
                              photopath: ("assets/image/read.png"),
                              ontap: () {
                                f1.unfocus();
                                Navigator.pushReplacement(context,
                                    AnimatingRoute(Screen: ReadingScreen()));
                                souraName = _searchResult[index].name;
                                ayah = _searchResult[index].ayahs;
                              },
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: Container(
                            height: ScreenUtil().setHeight(200),
                            width: ScreenUtil().screenWidth,
                            child: SvgPicture.asset(
                              "assets/icons/search1.svg",
                              fit: BoxFit.contain,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
              ],
            )),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    List<Surah> soura = souraData;
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    soura.forEach((soura) {
      if (soura.name.contains(text))
        _searchResult.add(soura);
      else if (soura.name.endsWith(text)) _searchResult.add(soura);
    });
    setState(() {});
  }
}
