class CryptoData {
  String symbol;
  double precio;
  double volumen;
  double porcentaje;
  double alto;
  double bajo;
  double cambioPrecio;
  double volumenCuota;

  CryptoData(
      {required this.symbol,
      required this.precio,
      required this.alto,
      required this.bajo,
      required this.porcentaje,
      required this.volumen,
      required this.volumenCuota,
      required this.cambioPrecio});

  factory CryptoData.fromJson(Map<String, dynamic> json) {
    return CryptoData(
      symbol: json['s'] ?? "",
      porcentaje: double.tryParse(json['P']) ?? 0.0,
      precio: double.tryParse(json['c']) ?? 0.0,
      alto: double.tryParse(json['h']) ?? 0.0,
      bajo: double.tryParse(json['l']) ?? 0.0,
      volumen: double.tryParse(json['v']) ?? 0.0,
      volumenCuota: double.tryParse(json['q']) ?? 0.0,
      cambioPrecio: double.tryParse(json['p']) ?? 0.0,
    );
  }

  void update(CryptoData nuevaData) {
    precio = nuevaData.precio;
    volumen = nuevaData.volumen;
    porcentaje = nuevaData.porcentaje;
    alto = nuevaData.alto;
    bajo = nuevaData.bajo;
    volumenCuota = nuevaData.volumenCuota;
  }
}
