import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  String uName = '';
  String name = '';
  String email = '';

  String get username => uName;
  String get clientName => name;
  String get emailAddress => email;

  void setUsername(String newUsername) {
    uName = newUsername;
    notifyListeners();
  }

  void setName(String newName) {
    name = newName;
    notifyListeners();
  }

  void setEmail (String newEmail){
    email = newEmail;
    notifyListeners();
  }


}