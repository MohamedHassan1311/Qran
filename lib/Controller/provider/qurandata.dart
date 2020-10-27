import 'package:flutter/foundation.dart';
import 'package:quran/Models/soura_model.dart';

class quranDataProvider extends ChangeNotifier {
  List<Surah> soura = [];
  addData(List<Surah> data) {
    soura = data;
    notifyListeners();
  }
}
