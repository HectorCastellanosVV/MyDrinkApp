import 'package:flutter/material.dart';
import 'package:mydrink_app/models/bebida_model.dart';
import 'package:mydrink_app/screens/update_bebida.dart';
import 'package:mydrink_app/services/bebidas_service.dart';
import 'package:mydrink_app/screens/add_bebida.dart';

class BebidasScreen extends StatefulWidget {
  const BebidasScreen({super.key});
  @override
  State<BebidasScreen> createState() => _BebidasScreenState();
}

class _BebidasScreenState extends State<BebidasScreen> {
  List<Bebida> bebidas = [];
  final BebidaService bebidaService = BebidaService();

  @override
  void initState() {
    super.initState();
    fetchBebidas();
  }

  void fetchBebidas() async {
    List<Bebida> fetchedBebidas = await bebidaService.getListBebidas(context);
    setState(() {
      bebidas = fetchedBebidas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Lista de bebidas",
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: bebidas.length,
                itemBuilder: (context, index) {
                  Bebida bebida = bebidas[index];
                  return buildBebidaCard(bebida);
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
              builder: (context) => const AddBebidaScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBebidaCard(Bebida bebida) {
    return GestureDetector(
      onTap: () async{
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateBebida(bebida: bebida),
            ));
        fetchBebidas();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bebida.nombre ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Precio: \$${bebida.precio?.toStringAsFixed(2) ?? ''}',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Stock: ${bebida.stock ?? ''}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
