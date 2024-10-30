import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mydrink_app/models/client_model.dart';
import 'package:mydrink_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ClientesService {
  Future<List<Client>> getListClients(BuildContext context) async {
    try {
      List<Client> listaC = [];
      var user = Provider.of<UserProvider>(context);
      String token = user.getUser()!.token!;
      var headers = {'Authorization': 'Bearer $token'};
      var response = await http.get(
          Uri.parse('http://192.168.1.162:3000/api/clientes'),
          headers: (headers));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var datos = data['body'];
        print(datos.runtimeType);
        if (datos is List) {
          for (var element in datos) {
            for (var key in element.keys) {
              var item = Client.fromJson(datos[key]);
              listaC.add(item);
            }
          }
        }
      } else {
        print(response.reasonPhrase);
      }
      return listaC;
    } catch (e) {
      print('Error $e');
      return [];
    }
  }
}
