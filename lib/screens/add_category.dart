import 'package:flutter/material.dart';
import 'package:mydrink_app/models/categoria_model.dart';
import 'package:mydrink_app/screens/home_screen.dart';
import 'package:mydrink_app/services/categorias_service.dart';
import 'package:mydrink_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatefulWidget{
  const AddCategoryScreen({super.key});
  @override
  State<AddCategoryScreen>  createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen>{
  TextEditingController nombreController = TextEditingController();


  @override
  Widget build(BuildContext context){
    var user = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Categoría'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            // Campo de texto para "Nombre de categoría"
            datosCategory(
              width: width,
              controller: nombreController,
              labelText: "Nombre de categoría",
              funcion: (value) {},
            ),
            const SizedBox(height: 40),

            // Botón "Agregar"
            ElevatedButton(
              onPressed: () async {
                Widget botonCancelar = TextButton(
                  child: const Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
                Widget botonContinuar = TextButton(
                  child: const Text("Continue"),
                  onPressed: () async {
                    Category categoria = Category(
                      nombre: nombreController.text,
                    );

                    // Llama al servicio para agregar la categoría
                    await CategoryService().addCategory(context, categoria, user);

                    // Navega a la pantalla de inicio después de agregar la categoría
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(usuario: user.getUser()!),
                      ),
                    );
                  },
                );

                // Diálogo de confirmación para agregar la categoría
                AlertDialog alert = AlertDialog(
                  title: const Text("Agregar categoría"),
                  content: const Text("¿Está seguro que desea agregar esta categoría?"),
                  actions: [
                    botonCancelar,
                    botonContinuar,
                  ],
                );

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              },
              child: const Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget datosCategory({
    required double width,
    required TextEditingController controller,
    required String labelText,
    required ValueChanged funcion,
  }) {
    return SizedBox(
      width: width,
      child: TextFormField(
        enabled: true,
        controller: controller,
        onChanged: funcion,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}