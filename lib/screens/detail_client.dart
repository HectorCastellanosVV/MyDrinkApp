import 'package:flutter/material.dart';
import 'package:mydrink_app/models/client_model.dart';
import 'package:mydrink_app/providers/user_provider.dart';
import 'package:mydrink_app/screens/home_screen.dart';
import 'package:mydrink_app/services/clientes_service.dart';
import 'package:provider/provider.dart';

class DetailClientScreen extends StatefulWidget {
  final Client cliente;
  const DetailClientScreen({super.key, required this.cliente});

  @override
  State<DetailClientScreen> createState() => DetailClientScreenState();
}

class DetailClientScreenState extends State<DetailClientScreen> {
  late Client cliente;
  TextEditingController nombreController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController comentariosController = TextEditingController();
  bool editando = false;

  @override
  void initState() {
    super.initState();
    cliente = widget.cliente;
    nombreController.text = cliente.nombre!;
    correoController.text = cliente.correo!;
    telefonoController.text = cliente.telefono!;
    comentariosController.text = cliente.comentarios!;
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    //double height = size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalles de cliente'),
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
              Text(
                'ID Cliente: ${cliente.idCliente}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              datosUser(
                width: width,
                controller: nombreController,
                labelText: "Nombre de cliente",
                funcion: (value) {
                  cliente.nombre = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              datosUser(
                width: width,
                controller: correoController,
                labelText: "Correo de cliente",
                funcion: (value) {
                  cliente.correo = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              datosUser(
                width: width,
                controller: telefonoController,
                labelText: "Teléfono de cliente",
                funcion: (value) {
                  cliente.telefono = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              datosUser(
                width: width,
                controller: comentariosController,
                labelText: "Comentarios de cliente",
                funcion: (value) {
                  cliente.comentarios = value;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          editando = !editando;
                        });
                        if (!editando) {
                          Client cliente = Client(
                              idCliente: widget.cliente.idCliente,
                              nombre: nombreController.text,
                              correo: correoController.text,
                              telefono: telefonoController.text,
                              comentarios: comentariosController.text);
                          await ClientesService()
                              .updateClient(context, cliente, user);
                          Navigator.push(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(usuario: user.getUser()!),
                              ));
                        }
                      },
                      child: Text(!editando ? 'Editar' : 'Guardar')),
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
                            await ClientesService()
                                .deleteClient(context, cliente.idCliente, user);
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
                          title: const Text("Eliminar cliente"),
                          content: const Text(
                              "¿Está seguro que desea eliminar este cliente?"),
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
                      child: const Text('Eliminar'))
                ],
              )
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
          enabled: editando,
          controller: controller,
          onChanged: funcion,
          decoration: InputDecoration(
              labelText: labelText,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        ));
  }
}
