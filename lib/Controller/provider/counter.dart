import 'package:flutter/cupertino.dart';

class counter extends ChangeNotifier{
int count =0;
void incrementCounter() {
    count++;
    notifyListeners();
  }
   void RestCounter() {
    count=0;
    notifyListeners();
  }

}