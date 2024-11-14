import 'package:flutter/material.dart';
import 'package:mydrink_app/models/user_model.dart';
import 'package:mydrink_app/providers/user_provider.dart';
import 'package:mydrink_app/screens/add_client.dart';
import 'package:mydrink_app/screens/detail_client.dart';
import 'package:mydrink_app/services/clientes_service.dart';
import 'package:mydrink_app/screens/add_category.dart';
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
    //Size size = MediaQuery.of(context).size;
    //double width = size.width;
    //double height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.person, size: 38),
                Text('Hola ${widget.usuario.username}!',
                    style: const TextStyle(fontSize: 24)),
                IconButton(
                    onPressed: () {
                      user.logOut();
                      setState(() {});
                    },
                    icon: const Icon(Icons.exit_to_app)),
                IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddCategoryScreen(), // Redirige a la nueva pantalla
                          ),
                      );
                }, icon: const Icon(Icons.category),),
                IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BebidasScreen(), //redirige a bebidas
                          ),
                      );
                }, icon: const Icon(Icons.local_bar),)
              ],
            ),
            const SizedBox(height: 30),
            const Text('Lista de usuarios:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: listaClientes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '${listaClientes[index].idCliente} ${listaClientes[index].nombre ?? ''}'),
                    subtitle: Text(listaClientes[index].correo ?? ''),
                    leading: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 30,
                        )),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailClientScreen(
                              cliente: listaClientes[index],
                            ),
                          ));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddClientScreen(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
