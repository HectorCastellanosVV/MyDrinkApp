import 'package:flutter/material.dart';
import 'package:mydrink_app/models/bebida_model.dart';
import 'package:mydrink_app/services/bebidas_service.dart';
import 'package:mydrink_app/screens/add_bebida.dart';

class BebidasScreen extends StatefulWidget {
  const BebidasScreen ({super.key});
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
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "My Drink",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bebidas",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: bebidas.length,
                itemBuilder: (context, index) {
                  Bebida bebida = bebidas[index];
                  return buildBebidaCard(bebida);
                },
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: OutlinedButton(
                onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddBebidaScreen(), //redirige a bebidas
                          ),
                      );
                },
                child: Text("Nueva Bebida"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBebidaCard(Bebida bebida) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Precio: \$${bebida.precio?.toStringAsFixed(2) ?? ''}',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 4),
              Text(
                'Stock: ${bebida.stock ?? ''}',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
