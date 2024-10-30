import 'package:flutter/material.dart';
import 'package:mydrink_app/models/user_model.dart';
import 'package:mydrink_app/providers/user_provider.dart';
import 'package:mydrink_app/services/clientes_service.dart';
import 'package:provider/provider.dart';

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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = Provider.of<UserProvider>(context);
    getClientes();
  }

  Future<void> getClientes() async {
    listaClientes = await ClientesService().getListClients(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.person, size: 42),
                const SizedBox(width: 10),
                Text('Hola ${widget.usuario.username}!',
                    style: const TextStyle(fontSize: 24)),
                IconButton(
                    onPressed: () {
                      user.logOut();
                      setState(() {});
                    },
                    icon: Icon(Icons.exit_to_app))
              ],
            ),
            const SizedBox(height: 30),
            Text('Lista de usuarios:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: listaClientes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(listaClientes[index].nombre ?? ''),
                    subtitle: Text(listaClientes[index].correo ?? ''),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
