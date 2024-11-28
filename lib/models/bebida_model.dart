class Bebida {
  int? idBebida;
  String? nombre;
  double? precio;
  int? categoriaId;
  int? stock;

  Bebida(
      {this.idBebida, this.nombre, this.precio, this.categoriaId, this.stock});

  factory Bebida.fromJson(Map<String, dynamic> json) => Bebida(
      idBebida: json['BebidaID'] as int,
      nombre: json['Nombre'],
      precio: json['Precio'] is double
          ? json['Precio']
          : double.tryParse(json['Precio']) ?? 0,
      categoriaId:
          (json['CategoriaID'] != null) ? json['CategoriaID'] as int : 5,
      stock: json['Stock'] as int);
}
