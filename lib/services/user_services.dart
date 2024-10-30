import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mydrink_app/models/user_model.dart';
import 'package:mydrink_app/providers/user_provider.dart';

class UserServices {
  Future<User?> login(
      {required String username, required String password}) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Origin': 'http://192.168.1.161'
      };
      var response = await http.post(
          Uri.parse('http://192.168.1.162:3000/api/login'),
          headers: (headers),
          body: json.encode({"username": username, "password": password}));

      if (response.statusCode == 200) {
        final authResponse = jsonDecode(response.body);
        User user = User.fromJson(authResponse,username,password);
        await UserProvider().login(user);
        return user;
      } else {
        print(response.reasonPhrase);
        return null;
      }
    } catch (e) {
      print('Error $e');
      return null;
    }
  }
}
