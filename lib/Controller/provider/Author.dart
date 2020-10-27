import 'package:flutter/cupertino.dart';

class Author extends ChangeNotifier {
  String author;

  changeAuthor(String name) {
    author = name;
    notifyListeners();
  }
}
