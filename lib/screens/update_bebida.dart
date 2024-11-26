import 'package:flutter/material.dart';
import 'package:mydrink_app/models/bebida_model.dart';
import 'package:mydrink_app/providers/user_provider.dart';
import 'package:mydrink_app/screens/bebidas.dart';
import 'package:mydrink_app/services/bebidas_service.dart';
import 'package:mydrink_app/services/categorias_service.dart';
import 'package:provider/provider.dart';

class UpdateBebida extends StatefulWidget {
  final Bebida bebida;
  const UpdateBebida({super.key, required this.bebida});

  @override
  State<UpdateBebida> createState() => _UpdateBebidaState();
}

class _UpdateBebidaState extends State<UpdateBebida> {
  TextEditingController idBebidaController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  List<DropdownMenuItem> items = [];
  late int valorActual;
  @override
  void initState() {
    super.initState();
    idBebidaController.text = '${widget.bebida.idBebida}';
    nombreController.text = '${widget.bebida.nombre}';
    precioController.text = '${widget.bebida.precio}';
    stockController.text = '${widget.bebida.stock}';
    valorActual = widget.bebida.idBebida ?? 5;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mostrarItems();
  }

  void mostrarItems() async {
    var datos = await CategoryService().getListCategories(context);
    List<DropdownMenuItem> categoriasDropdown = datos.map((dato) {
      return DropdownMenuItem(
        value: dato.idCategoria,
        child: Text(dato.nombre ?? 'Sin nombre de categoría'),
      );
    }).toList();
    setState(() {
      items = categoriasDropdown;
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Editar bebida'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ID Categoría'),
              DropdownButton(
                value: valorActual,
                items: items,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      valorActual = value;
                    });
                  }
                },
              ),
              TextField(
                controller: idBebidaController,
                enabled: false,
                decoration: const InputDecoration(
                  labelText: 'ID Bebida',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: precioController,
                decoration: const InputDecoration(
                  labelText: 'Precio',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(
                  labelText: 'Stock',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Bebida bebidaActual = Bebida(
                        categoriaId: valorActual,
                        idBebida: widget.bebida.idBebida,
                        nombre: nombreController.text,
                        precio: double.parse(precioController.text),
                        stock: int.parse(stockController.text),
                      );
                      await BebidaService()
                          .updateBebida(context, bebidaActual, user);
                      if (context.mounted) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BebidasScreen(),
                            ));
                      }
                    },
                    child: const Text('Actualizar'),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Eliminar'),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
