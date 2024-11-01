import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mydrink_app/config/environments.dart';
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
          Uri.parse('${Environments.direccionServer}/api/clientes'),
          headers: (headers));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var datos = data['body'];
        if (datos is List) {
          for (Map<String, dynamic> element in datos) {
            var item = Client.fromJson(element);
            listaC.add(item);
          }
        }
      } else {}
      return listaC;
    } catch (e) {
      return [];
    }
  }

  Future<void> addClient(
      BuildContext context, Client cliente, UserProvider userProvider) async {
    try {
      String token = userProvider.getUser()!.token!;

      var headers = {
        'Origin': Environments.direccionUser,
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var response = await http.post(
          Uri.parse('${Environments.direccionServer}/api/clientes'),
          body: json.encode({
            "Nombre": cliente.nombre,
            "Correo": cliente.correo,
            "Telefono": cliente.telefono,
            "Comentarios": cliente.comentarios
          }),
          headers: headers);

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, children: [
          const Text('Datos agregados correctamente'),
        ]);
      } else {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, children: [
          const Text('Error al agregar el nuevo cliente'),
          Text('StatusCode: ${response.statusCode}'),
          Text('Message: ${response.reasonPhrase}'),
        ]);
      }
    } catch (e) {
      //
    }
  }

  Future<void> updateClient(
      BuildContext context, Client cliente, UserProvider userProvider) async {
    try {
      String token = userProvider.getUser()!.token!;

      var headers = {
        'Origin': Environments.direccionUser,
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var response = await http.put(
          Uri.parse(
              '${Environments.direccionServer}/api/clientes/${cliente.idCliente}'),
          body: json.encode({
            "Nombre": cliente.nombre,
            "Correo": cliente.correo,
            "Telefono": cliente.telefono,
            "Comentarios": cliente.comentarios
          }),
          headers: headers);

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, children: [
          const Text('Datos cambiados correctamente'),
        ]);
      } else {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, children: [
          const Text('Error al editar el nuevo cliente'),
          Text('StatusCode: ${response.statusCode}'),
          Text('Message: ${response.reasonPhrase}'),
        ]);
      }
    } catch (e) {
      //print('Error $e');
    }
  }

  Future<void> deleteClient(
      BuildContext context, int? idCliente, UserProvider user) async {
    try {
      String token = user.getUser()!.token!;
      var headers = {
        'Origin': Environments.direccionUser,
        'Authorization': 'Bearer $token'
      };

      var response = await http.delete(
          Uri.parse('${Environments.direccionServer}/api/clientes/$idCliente'),
          headers: headers);
      if (response.statusCode == 200 || response.statusCode == 204) {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, children: [
          const Text('Datos eliminados correctamente'),
        ]);
      } else {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, children: [
          const Text('Error al editar el nuevo cliente'),
          Text('StatusCode: ${response.statusCode}'),
          Text('Message: ${response.reasonPhrase}'),
        ]);
      }
    } catch (e) {
      //print('Error $e');
    }
  }
}
