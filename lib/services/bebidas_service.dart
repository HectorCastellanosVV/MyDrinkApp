import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mydrink_app/config/environments.dart';
import 'package:mydrink_app/models/bebida_model.dart';
import 'package:mydrink_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class BebidaService {
  Future<List<Bebida>> getListBebidas(BuildContext context) async {
    try {
      List<Bebida> listaBebidas = [];
      var user = Provider.of<UserProvider>(context, listen: false);
      String token = user.getUser()!.token!;
      var headers = {
        'Authorization': 'Bearer $token',
        'Origin': Environments.direccionUser,
      };
      var response = await http.get(
        Uri.parse('${Environments.direccionServer}/api/bebidas'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var datos = data['body'];
        if (datos is List) {
          for (Map<String, dynamic> element in datos) {
            var item = Bebida.fromJson(element);
            listaBebidas.add(item);
          }
        }
      }
      return listaBebidas;
    } catch (e) {
      return [];
    }
  }

  Future<void> addBebida(
      BuildContext context, Bebida bebida, UserProvider userProvider) async {
    try {
      String token = userProvider.getUser()!.token!;
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Origin': Environments.direccionUser,
      };
      var response = await http.post(
        Uri.parse('${Environments.direccionServer}/api/bebidas'),
        body: json.encode({
          "nombre": bebida.nombre,
          "precio": bebida.precio,
          "categoriaId": bebida.categoriaId,
          "stock": bebida.stock,
        }),
        headers: headers,
      );

      if (response.statusCode == 200 && context.mounted) {
        showAboutDialog(context: context, children: [
          const Text('Bebida agregada correctamente'),
        ]);
      } else if (context.mounted) {
        showAboutDialog(context: context, children: [
          const Text('Error al agregar la bebida'),
          Text('StatusCode: ${response.statusCode}'),
          Text('Message: ${response.reasonPhrase}'),
        ]);
      }
    } catch (e) {
      //
    }
  }

  Future<void> updateBebida(
      BuildContext context, Bebida bebida, UserProvider userProvider) async {
    try {
      String token = userProvider.getUser()!.token!;
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Origin': Environments.direccionUser,
      };
      var response = await http.put(
        Uri.parse(
            '${Environments.direccionServer}/api/bebidas/${bebida.idBebida}'),
        body: json.encode({
          "nombre": bebida.nombre,
          "precio": bebida.precio,
          "categoriaId": bebida.categoriaId,
          "stock": bebida.stock,
        }),
        headers: headers,
      );

      if (response.statusCode == 200 && context.mounted) {
        showAboutDialog(context: context, children: [
          const Text('Bebida actualizada correctamente'),
        ]);
      } else if (context.mounted) {
        showAboutDialog(context: context, children: [
          const Text('Error al actualizar la bebida'),
          Text('StatusCode: ${response.statusCode}'),
          Text('Message: ${response.reasonPhrase}'),
        ]);
      }
    } catch (e) {
      //
    }
  }

  Future<void> deleteBebida(
      BuildContext context, int? idBebida, UserProvider userProvider) async {
    try {
      String token = userProvider.getUser()!.token!;
      var headers = {
        'Authorization': 'Bearer $token',
        'Origin': Environments.direccionUser,
      };
      var response = await http.delete(
        Uri.parse('${Environments.direccionServer}/api/bebidas/$idBebida'),
        headers: headers,
      );

      if ((response.statusCode == 200 || response.statusCode == 204) &&
          context.mounted) {
        showAboutDialog(context: context, children: [
          const Text('Bebida eliminada correctamente'),
        ]);
      } else if (context.mounted) {
        showAboutDialog(context: context, children: [
          const Text('Error al eliminar la bebida'),
          Text('StatusCode: ${response.statusCode}'),
          Text('Message: ${response.reasonPhrase}'),
        ]);
      }
    } catch (e) {
      //
    }
  }
}
