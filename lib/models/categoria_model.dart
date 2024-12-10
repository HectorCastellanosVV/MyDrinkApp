class Category {
  int? idCategoria;
  String? nombre;
  Category(
      {this.idCategoria,
      this.nombre,});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        idCategoria: json['CategoriaID'] as int,
        nombre: json['Nombre'],
      );
}
