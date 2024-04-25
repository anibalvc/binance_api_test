import 'package:binance_api_test/core/models/crypto_data_response.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DetalleCryptoProvider with ChangeNotifier {
  late CryptoData _crypto = CryptoData(
      symbol: "",
      precio: 0,
      alto: 0,
      bajo: 0,
      porcentaje: 0,
      volumen: 0,
      volumenCuota: 0,
      cambioPrecio: 0);
  late List<BarChartGroupData> _last10 = [];
  CryptoData get crypto => _crypto;
  List<BarChartGroupData> get last10 => _last10;
  void setCrypto({required CryptoData crypto}) {
    _crypto = crypto;
    notifyListeners();
  }

  void addSpotToList({required BarChartGroupData spot}) {
    if (_last10.length < 8) {
      _last10.add(spot);
    } else {
      _last10.removeAt(0);
    }
    notifyListeners();
  }

  void cleanList() {
    _last10 = [];
    notifyListeners();
  }
}
