import 'package:flutter/material.dart';
import 'package:mydrink_app/models/user_model.dart';
import 'package:mydrink_app/providers/user_provider.dart';
import 'package:mydrink_app/screens/categorias_screen.dart';
import 'package:mydrink_app/screens/user_screen.dart';
import 'package:mydrink_app/services/clientes_service.dart';
import 'package:provider/provider.dart';
import 'package:mydrink_app/screens/bebidas.dart';

import '../models/client_model.dart';

class HomeScreen extends StatefulWidget {
  final User usuario;
  const HomeScreen({super.key, required this.usuario});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserProvider user;
  List<Client> listaClientes = [];

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getClientes();
  }

  Future<void> getClientes() async {
    listaClientes = await ClientesService().getListClients(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hola ${widget.usuario.username ?? ''}'),
        leading: IconButton(
            onPressed: () {
              user.logOut();
            },
            icon: const Icon(Icons.exit_to_app)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text('Selecciona una opción para continuar'),
            const SizedBox(
              height: 20,
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              children: [
                getCardSelected(
                  color: Colors.red,
                  dato: "Clientes",
                  icon: Icons.people,
                  pressed: () {
                    Navigator.push(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserScreen(
                            usuario: widget.usuario,
                          ),
                        ));
                  },
                ),
                getCardSelected(
                  color: const Color.fromARGB(255, 240, 180, 0),
                  dato: "Bebidas",
                  icon: Icons.no_drinks,
                  pressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BebidasScreen(),
                      ),
                    );
                  },
                ),
                getCardSelected(
                  color: Colors.blue,
                  dato: "Categorías",
                  icon: Icons.category_outlined,
                  pressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CategoriasScreen(),
                        ));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getCardSelected(
      {required Color color,
      required String dato,
      required IconData icon,
      required GestureTapCallback? pressed}) {
    return GestureDetector(
      onTap: pressed,
      child: Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            Text(
              dato,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
