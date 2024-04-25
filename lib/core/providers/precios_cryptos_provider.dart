import 'package:binance_api_test/core/models/crypto_data_response.dart';
import 'package:flutter/material.dart';

class PreciosCryptosProvider with ChangeNotifier {
  late List<CryptoData> _cryptos = [];
  List<CryptoData> get cryptos => _cryptos;
  void setCryptos({required List<CryptoData> cryptos}) {
    _cryptos = cryptos;
    notifyListeners();
  }
}
