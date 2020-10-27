import 'package:flutter/foundation.dart';

class TextSizeProvider extends ChangeNotifier {
  var text_size = 30.0;
  cangeTextSize({newvalue}) {
    text_size = newvalue;

    notifyListeners();
  }
}
