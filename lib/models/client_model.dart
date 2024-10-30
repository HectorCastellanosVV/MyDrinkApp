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

  factory Client.fromJson(Map<String, String> json) => Client(
        idCliente: int.tryParse(json['ClienteID'] as String),
        nombre: json['Nombre'],
        correo: json['Correo'],
        telefono: json['Telefono'],
        comentarios: json['Comentarios'],
      );
}
