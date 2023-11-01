import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  String uName = '';
  String name = '';

  String get username => uName;
  String get clientName => name;

  void setUsername(String newUsername) {
    uName = newUsername;
    notifyListeners();
  }

  void setName(String newName) {
    name = newName;
    notifyListeners();
  }

}