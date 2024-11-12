class Bebida{
  int? idBebida;
  String? nombre;
  double? precio;
  int? categoriaId;

  Bebida({
        this.idBebida,
        this.nombre,
        this.precio,
        this.categoriaId
      });

  factory Bebida.fromJson(Map<String, dynamic> json) => Bebida(
    idBebida: json['BebidaId'] as int,
    nombre: json['Nombre'],
        precio: json['precio'],
        categoriaId: json['categoriaId']as int,
      );

}