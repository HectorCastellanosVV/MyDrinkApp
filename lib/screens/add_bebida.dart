import 'package:flutter/material.dart';
import 'package:mydrink_app/models/bebida_model.dart';
import 'package:mydrink_app/providers/user_provider.dart';
import 'package:mydrink_app/screens/home_screen.dart';
import 'package:mydrink_app/services/bebidas_service.dart';
import 'package:provider/provider.dart';

class AddBebidaScreen extends StatefulWidget {
  const AddBebidaScreen({super.key});

  @override
  State<AddBebidaScreen> createState() => _AddBebidaScreen();
}

class _AddBebidaScreen extends State<AddBebidaScreen> {
  double? precio;
  int? stock;
  TextEditingController nombreController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController categoriaController = TextEditingController();
  TextEditingController stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    precio = double.tryParse(precioController.text) ?? 0;
    stock = int.tryParse(stockController.text);
    var user = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nueva bebida'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              datosDrink(
                width: width,
                controller: nombreController,
                labelText: "Nombre",
                funcion: (value) {},
              ),
              const SizedBox(
                height: 20,
              ),
              datosDrink(
                width: width,
                controller: precioController,
                labelText: "Precio",
                funcion: (value) {},
              ),
              const SizedBox(
                height: 20,
              ),
              datosDrink(
                width: width,
                controller: stockController,
                labelText: "stock",
                funcion: (value) {},
              ),
              const SizedBox(
                height: 20,
              ),
              datosDrink(
                width: width,
                controller: categoriaController,
                labelText: "categoria",
                funcion: (value) {},
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Widget cancelButton = TextButton(
                      child: const Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
                    Widget continueButton = TextButton(
                      child: const Text("Continue"),
                      onPressed: () async {
                        Bebida drink = Bebida(
                          nombre: nombreController.text,
                          precio: precio,
                          stock: int.tryParse(stockController.text) ?? 0,
                          categoriaId:
                              int.tryParse(categoriaController.text) ?? 5,
                        );
                        await BebidaService().addBebida(context, drink, user);
                        Navigator.push(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(usuario: user.getUser()!),
                            ));
                      },
                    );
                    AlertDialog alert = AlertDialog(
                      title: const Text("Agregar cliente"),
                      content: const Text(
                          "¿Está seguro que desea agregar este cliente?"),
                      actions: [
                        cancelButton,
                        continueButton,
                      ],
                    );
                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                  child: const Text('Agregar'))
            ],
          ),
        ));
  }

  Widget datosDrink(
      {required double width,
      required TextEditingController controller,
      required String labelText,
      required ValueChanged funcion}) {
    return SizedBox(
        width: width,
        child: TextFormField(
          enabled: true,
          controller: controller,
          onChanged: funcion,
          decoration: InputDecoration(
              labelText: labelText,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        ));
  }
}
