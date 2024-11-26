import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mydrink_app/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User? usuario = User();

  final userBox = Hive.box<User>('user');

  UserProvider() {
    usuario = getUser();
  }

  login(User user) async {
    await userBox.put(user.username, user);
    usuario = user;
    notifyListeners();
  }

  User? getUser() {
    if (userBox.values.isNotEmpty) {
      return userBox.values.first;
    }else{
      return null;
    }
  }

  logOut() async {
    await userBox.delete(usuario?.username ?? '');
    usuario = User();
    notifyListeners();
  }
}
