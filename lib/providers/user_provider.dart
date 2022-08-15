import 'package:flutter/cupertino.dart';
import 'package:jobbiest_flutter/models/user_model.dart';

class UserProvider with ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  set user(UserModel newUser) {
    _user = newUser;
    notifyListeners();
  }
}
