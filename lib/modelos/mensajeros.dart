class Mensajero {
  final String id;
  final String nombre;
  final String foto;
  final String placa;
  final String telefono;
  final String whatsapp;
  final String moto;
  final String soat;
  final String tecno;
  final String activo;

  Mensajero({
    this.id,
    this.nombre,
    this.foto,
    this.placa,
    this.telefono,
    this.whatsapp,
    this.moto,
    this.soat,
    this.tecno,
    this.activo,
  });

  factory Mensajero.fromJson(Map<String, dynamic> json) {
    return Mensajero(
      id: json['id'],
      nombre: json['nombre'],
      foto: json['foto'],
      placa: json['placa'],
      telefono: json['telefono'],
      whatsapp: json['whatsapp'],
      moto: json['moto'],
      soat: json['soat'],
      tecno: json['tecno'],
      activo: json['activo'],
    );
  }
}
