import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mydrink_app/config/environments.dart';
import 'package:mydrink_app/models/categoria_model.dart';

class CategoryService {
  Future<List<Category>> getListCategories(BuildContext context) async {
    try {
      List<Category> listaC = [];
      var response = await http.get(
          Uri.parse('${Environments.direccionServer}/api/categorias'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var datos = data['body'];
        if (datos is List) {
          for (Map<String, dynamic> element in datos) {
            var item = Category.fromJson(element);
            listaC.add(item);
          }
        }
      }
      return listaC;
    } catch (e) {
      return [];
    }
  }

  Future<void> addCategory(BuildContext context, Category category) async {
    try {
      var response = await http.post(
          Uri.parse('${Environments.direccionServer}/api/categorias'),
          body: json.encode({
            "Nombre": category.nombre,
          }),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        showAboutDialog(context: context, children: [
          const Text('Categoría agregada correctamente'),
        ]);
      } else {
        showAboutDialog(context: context, children: [
          const Text('Error al agregar la categoría'),
          Text('StatusCode: ${response.statusCode}'),
          Text('Message: ${response.reasonPhrase}'),
        ]);
      }
    } catch (e) {
      //
    }
  }

  Future<void> updateCategory(
      BuildContext context, Category category) async {
    try {
      var response = await http.put(
          Uri.parse(
              '${Environments.direccionServer}/api/categorias/${category.idCategoria}'),
          body: json.encode({
            "Nombre": category.nombre,
          }),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        showAboutDialog(context: context, children: [
          const Text('Categoría actualizada correctamente'),
        ]);
      } else {
        showAboutDialog(context: context, children: [
          const Text('Error al actualizar la categoría'),
          Text('StatusCode: ${response.statusCode}'),
          Text('Message: ${response.reasonPhrase}'),
        ]);
      }
    } catch (e) {
      //
    }
  }

  Future<void> deleteCategory(BuildContext context, int? idCategoria) async {
    try {
      var response = await http.delete(
          Uri.parse('${Environments.direccionServer}/api/categorias/$idCategoria'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200 || response.statusCode == 204) {
        showAboutDialog(context: context, children: [
          const Text('Categoría eliminada correctamente'),
        ]);
      } else {
        showAboutDialog(context: context, children: [
          const Text('Error al eliminar la categoría'),
          Text('StatusCode: ${response.statusCode}'),
          Text('Message: ${response.reasonPhrase}'),
        ]);
      }
    } catch (e) {
      //
    }
  }
}
