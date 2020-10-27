import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioTimeProvid extends ChangeNotifier {
  String CurentTime = "0:0";
  String fullTime = "0:0";
  bool play = false;
  bool autoplay=false ;
  SharedPreferences prefs;
  changeCurentTime({curentime}) {
    CurentTime = curentime;
    notifyListeners();
  }

  chaneFullTime({Fulltime}) {
    fullTime = Fulltime;
    notifyListeners();
  }

  canangeAutoPlay({AutoPlay}) {

    autoplay = AutoPlay;
    prefs.setBool("key", autoplay);
    notifyListeners();
  }
  getDate() async {
    prefs = await SharedPreferences.getInstance();

  var auto = prefs.getBool("key");
   if(auto==null){
     return autoplay;
   }

   else {
      autoplay=auto;
      notifyListeners();
      return auto;
    }
  }
  caneAudioStatus({Play}) {
    play = Play;
    notifyListeners();
  }
}
