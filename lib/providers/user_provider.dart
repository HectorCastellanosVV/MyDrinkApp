import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mydrink_app/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  late User usuario = User();

  final userBox = Hive.box<User>('user');

  login(User user) async {
    await userBox.put(user.username, user);
    usuario = user;
    notifyListeners();
  }

  User? getUser() {
    return userBox.get(usuario.username);
  }

  logOut() async {
    await userBox.delete(usuario.username);
    usuario = User();
    notifyListeners();
  }
}
