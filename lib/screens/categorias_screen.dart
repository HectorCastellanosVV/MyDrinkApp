import 'package:flutter/material.dart';
import 'package:mydrink_app/models/categoria_model.dart';
import 'package:mydrink_app/screens/add_category.dart';
import 'package:mydrink_app/screens/update_category_screen.dart';
import 'package:mydrink_app/services/categorias_service.dart';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  State<CategoriasScreen> createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  List<Category> categorias = [];
  final CategoryService categoryService = CategoryService();

  @override
  void initState() {
    super.initState();
    getCategorias();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getCategorias();
  }

  void getCategorias() async {
    List<Category> listaC = await categoryService.getListCategories(context);
    setState(() {
      categorias = listaC;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de categorías'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: categorias.length,
          itemBuilder: (context, index) {
            return getCategoriaCard(index, context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddCategoryScreen(),
              ));
          getCategorias();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  ListTile getCategoriaCard(int index, BuildContext context) {
    return ListTile(
      title: Text(categorias[index].nombre ?? 'Sin nombre de categoría'),
      subtitle: Text('${categorias[index].idCategoria ?? ''}'),
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateCategoryScreen(
                category: categorias[index],
              ),
            ));
        getCategorias();
      },
    );
  }
}
