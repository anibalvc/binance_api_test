import 'dart:convert';

import 'package:binance_api_test/core/authentication_client.dart';
import 'package:binance_api_test/core/base/base_view_model.dart';
import 'package:binance_api_test/core/models/ticker_24h_response.dart';
import 'package:binance_api_test/core/models/crypto_data_response.dart';
import 'package:binance_api_test/core/models/usuarios_response.dart';
import 'package:binance_api_test/core/providers/detalle_crypto_provider.dart';
import 'package:binance_api_test/core/providers/precios_cryptos_provider.dart';
import 'package:binance_api_test/core/services/navigator_service.dart';
import 'package:binance_api_test/views/detalles_crypto/detalles_crypto_view.dart';
import 'package:binance_api_test/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';

import '../../core/locator.dart';

class HomeViewModel extends BaseViewModel {
  /*  final _authenticationClient = locator<AuthenticationClient>(); */
  final listController = ScrollController();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final _autenticationClient = locator<AuthenticationClient>();
  final _navigationService = locator<NavigatorService>();
  final cryptos = ['bnb', 'bch', 'qnt', 'ltc', 'sol'];

  bool _loading = false;

  bool get isLogged => _autenticationClient.isLogged;

  NavigatorService get navigator => _navigationService;

  final logger = Logger();

  late int idBarco = 0;
  late UsuariosData usuario;
  int tipoBarcoSelected = 0;
  List<Ticker24hData> tickets = [];
  List<CryptoData> cryptosList = [];

  HomeViewModel();

  GlobalKey<ScaffoldState> get drawerKey => _drawerKey;

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> onInit(BuildContext context) async {
    loading = true;
    usuario = _autenticationClient.loadUsuario;
    webApiSocket(context);
    loading = false;
  }

  Future<void> moveToCrypto(BuildContext context, CryptoData crypto) async {
    var providerDetallesCrypto =
        Provider.of<DetalleCryptoProvider>(context, listen: false);
    providerDetallesCrypto.setCrypto(crypto: crypto);
    providerDetallesCrypto.cleanList();
    _navigationService.navigateToPageDetalles(
        DetallesCryptoView.routeName, crypto.symbol.toLowerCase());
  }

  webApiSocket(BuildContext context) {
    var providerPreciosCryptos =
        Provider.of<PreciosCryptosProvider>(context, listen: false);
    for (var element in cryptos) {
      final channel = IOWebSocketChannel.connect(
          "wss://stream.binance.com:9443/ws/${element}usdt@ticker",
          pingInterval: const Duration(seconds: 5));
      channel.stream.listen((message) {
        var getData = jsonDecode(message);
        if (cryptosList.any((element) =>
            element.symbol == getData['s'].toString().replaceAll("USDT", ""))) {
          var replaced = cryptosList.firstWhere((element) =>
              element.symbol == getData['s'].replaceAll("USDT", ""));
          replaced.precio = double.parse(getData['c']);
          replaced.alto = double.parse(getData['h']);
          replaced.bajo = double.parse(getData['l']);
          replaced.volumenCuota = double.parse(getData['q']);
          replaced.cambioPrecio = double.parse(getData['p']);
          replaced.porcentaje = double.parse(getData['P']);
          replaced.volumen = double.parse(getData['v']);
        } else {
          cryptosList.add(CryptoData(
              symbol: getData['s'].toString().replaceAll("USDT", ""),
              precio: double.parse(getData['c']),
              alto: double.parse(getData['h']),
              bajo: double.parse(getData['l']),
              volumenCuota: double.parse(getData['q']),
              cambioPrecio: double.parse(getData['p']),
              porcentaje: double.parse(getData['P']),
              volumen: double.parse(getData['v'])));
        }
        providerPreciosCryptos.setCryptos(cryptos: cryptosList);
        notifyListeners();
      }, onError: (error) {
        Dialogs.error(msg: "Error al consumir el api de binance");
      });
    }
  }
}
