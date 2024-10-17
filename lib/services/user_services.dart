import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mydrink_app/config/environments.dart';
import 'package:mydrink_app/models/user_model.dart';
import 'package:mydrink_app/providers/user_provider.dart';

class UserServices {
  Future<User?> login(
      {required String username, required String password}) async {
    try {
      final authData = {
        'username': username,
        'password': password,
      };
      final baseUrl = '${Environments.apiURl}/login';
      final uri = Uri.parse(baseUrl);
      final response = await http.post(uri, body: (authData));
      if (response.statusCode == 200) {
        final authResponse = jsonDecode(response.body);
        final user = User.fromJson(authResponse);
        user.username = username;
        user.password = password;
        await UserProvider().login(user);
        return user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
