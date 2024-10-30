import 'package:flutter/material.dart';
import 'package:mydrink_app/models/client_model.dart';
import 'package:mydrink_app/providers/user_provider.dart';
import 'package:mydrink_app/screens/home_screen.dart';
import 'package:mydrink_app/services/clientes_service.dart';
import 'package:provider/provider.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController comentariosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nuevo cliente'),
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
              datosUser(
                width: width,
                controller: nombreController,
                labelText: "Nombre de cliente",
                funcion: (value) {},
              ),
              const SizedBox(
                height: 20,
              ),
              datosUser(
                width: width,
                controller: correoController,
                labelText: "Correo de cliente",
                funcion: (value) {},
              ),
              const SizedBox(
                height: 20,
              ),
              datosUser(
                width: width,
                controller: telefonoController,
                labelText: "Teléfono de cliente",
                funcion: (value) {},
              ),
              const SizedBox(
                height: 20,
              ),
              datosUser(
                width: width,
                controller: comentariosController,
                labelText: "Comentarios de cliente",
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
                        Client cliente = Client(
                          nombre: nombreController.text,
                          correo: correoController.text,
                          telefono: telefonoController.text,
                          comentarios: comentariosController.text,
                        );
                        await ClientesService().addClient(context, cliente,user);
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

  Widget datosUser(
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
