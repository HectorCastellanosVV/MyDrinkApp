import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mydrink_app/config/environments.dart';
import 'package:mydrink_app/models/user_model.dart';
import 'package:mydrink_app/providers/user_provider.dart';

class UserServices {
  Future<User?> login(
      {required String username, required String password}) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Origin': Environments.direccionUser
      };
      var response = await http.post(
          Uri.parse('${Environments.direccionServer}/api/login'),
          headers: (headers),
          body: json.encode({"username": username, "password": password}));

      if (response.statusCode == 200) {
        final authResponse = jsonDecode(response.body);
        User user = User.fromJson(authResponse, username, password);
        await UserProvider().login(user);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      //print('Error $e');
      return null;
    }
  }
}
