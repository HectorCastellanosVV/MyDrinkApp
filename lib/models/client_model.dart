class Client {
  int? idCliente;
  String? nombre;
  String? correo;
  String? telefono;
  String? comentarios;
  Client(
      {this.idCliente,
      this.nombre,
      this.correo,
      this.telefono,
      this.comentarios});

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        idCliente: json['ClienteID'] as int,
        nombre: json['Nombre'],
        correo: json['Correo'],
        telefono: json['Telefono'],
        comentarios: json['Comentarios'],
      );
}
