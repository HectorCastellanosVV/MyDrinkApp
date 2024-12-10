import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mydrink_app/config/environments.dart';
import 'package:mydrink_app/models/user_model.dart';
import 'package:mydrink_app/providers/user_provider.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class UserServices {
  Future<User?> login(
      {required String username, required String password}) async {
    try {
      final key = encrypt.Key.fromUtf8('32charlongencryptionkey32');
      final iv = encrypt.IV.fromLength(16);

      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      final encryptedPassword = encrypter.encrypt(password, iv: iv);

      var headers = {
        'Content-Type': 'application/json',
        'Origin': Environments.direccionUser
      };

      var response = await http.post(
        Uri.parse('${Environments.direccionServer}/api/login'),
        headers: (headers),
        body: json.encode({
          "username": username,
          "password": encryptedPassword
              .base64, // Envía la contraseña encriptada en base64
        }),
      );

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
