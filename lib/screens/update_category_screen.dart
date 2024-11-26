import 'package:flutter/material.dart';
import 'package:mydrink_app/models/categoria_model.dart';
import 'package:mydrink_app/providers/user_provider.dart';
import 'package:mydrink_app/screens/categorias_screen.dart';
import 'package:mydrink_app/services/categorias_service.dart';
import 'package:provider/provider.dart';

class UpdateCategoryScreen extends StatefulWidget {
  final Category category;
  const UpdateCategoryScreen({super.key, required this.category});

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  final TextEditingController _categoryName = TextEditingController();
  final TextEditingController _categoryID = TextEditingController();

  @override
  void initState() {
    super.initState();
    _categoryID.text = '${widget.category.idCategoria}';
    _categoryName.text = '${widget.category.nombre}';
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar categoría'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: _categoryID,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'ID categoría',
              ),
            ),
            TextField(
              controller: _categoryName,
              decoration: const InputDecoration(
                labelText: 'Nombre de categoría',
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Update the category
                    // Assuming the category name is stored in _categoryName
                    Category category = Category(
                      idCategoria: widget.category.idCategoria,
                      nombre: _categoryName.text,
                    );
                    await CategoryService()
                        .updateCategory(context, category, user);
                    if (context.mounted) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CategoriasScreen(),
                          ));
                    }
                  },
                  child: const Text('Actualizar categoría'),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Update the category
                    // Assuming the category name is stored in _categoryName.
                    Category category = Category(
                      idCategoria: widget.category.idCategoria,
                      nombre: _categoryName.text,
                    );
                    await CategoryService()
                        .deleteCategory(context, category.idCategoria, user);
                    if (context.mounted) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CategoriasScreen(),
                          ));
                    }
                  },
                  child: const Text('Eliminar categoría'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate back to the category list screen
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
