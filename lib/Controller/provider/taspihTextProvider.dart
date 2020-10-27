import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaspihTextProvider extends ChangeNotifier {
  List<String> doaatext = [
    "استغفر الله العظيم",
    "سبحان الله",
    "الحمد الله",
    "الله أكبر",
    "صلي علي محمد",
    "سبحان الله وبحمده سبحان الله العظيم",
    "لا حول ولا قوة الا بالله"
  ];
  bool storeData = false;
  SharedPreferences prefs;
  saveData(doaatext, vlaue) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setStringList("doaatext", doaatext);
    prefs.setBool("storeData", vlaue);
  }

  getDate() async {
    prefs = await SharedPreferences.getInstance();
    storeData = prefs.getBool("storeData");
    if (storeData == true) {
      notifyListeners();
      return doaatext = prefs.getStringList("doaatext");
    } else
      return doaatext = doaatext;
  }

  deletDoaa({index}) async {
    prefs = await SharedPreferences.getInstance();
    doaatext.removeAt(index);
    prefs.setStringList("doaatext", doaatext);
    notifyListeners();
  }

  String TextinField = "استغفر الله العظيم";
  editText({String Txt}) {
    TextinField = Txt;
    notifyListeners();
  }

  addDoaa({String Doaa, vlue}) async {
    doaatext.add(Doaa);

    notifyListeners();
    saveData(doaatext, vlue);
  }
}
