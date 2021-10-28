import 'package:flutter/cupertino.dart';

class UserViewModel extends ChangeNotifier {
  bool isLogin = true;
  changeTo(bool check) {
    isLogin = check;
    notifyListeners();
  }
}
