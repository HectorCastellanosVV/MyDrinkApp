class Bebida{
  int? idBebida;
  String? nombre;
  double? precio;
  int? categoriaId;
  int? stock;

  Bebida({
        this.idBebida,
        this.nombre,
        this.precio,
        this.categoriaId,
        this.stock
      });

  factory Bebida.fromJson(Map<String, dynamic> json) => Bebida(
    idBebida: json['BebidaId'] as int,
    nombre: json['Nombre'],
        precio: json['precio'] as double,
        categoriaId: json['categoriaId']as int,
        stock: json['stock'] as int
      );

}