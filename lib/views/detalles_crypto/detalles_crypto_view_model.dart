import 'dart:convert';

import 'package:binance_api_test/core/base/base_view_model.dart';
import 'package:binance_api_test/core/locator.dart';
import 'package:binance_api_test/core/models/ticker_24h_response.dart';
import 'package:binance_api_test/core/models/crypto_data_response.dart';
import 'package:binance_api_test/core/models/usuarios_response.dart';
import 'package:binance_api_test/core/providers/detalle_crypto_provider.dart';
import 'package:binance_api_test/core/services/navigator_service.dart';
import 'package:binance_api_test/theme/theme.dart';
import 'package:binance_api_test/widgets/app_dialogs.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';

class DetallesCryptoViewModel extends BaseViewModel {
  /*  final _authenticationClient = locator<AuthenticationClient>(); */
  final listController = ScrollController();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final _navigationService = locator<NavigatorService>();

  bool _loading = false;

  final logger = Logger();
  final String symbol;
  late IOWebSocketChannel channel = IOWebSocketChannel.connect(
      "wss://stream.binance.com:9443/ws/${symbol.toLowerCase()}usdt@ticker",
      pingInterval: const Duration(seconds: 5));

  late int idBarco = 0;
  late UsuariosData usuario;
  int tipoBarcoSelected = 0;
  List<Ticker24hData> tickets = [];
  CryptoData crypto;

  DetallesCryptoViewModel({required this.crypto, required this.symbol});

  GlobalKey<ScaffoldState> get drawerKey => _drawerKey;

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> onInit(BuildContext context) async {
    loading = true;
    webSocket(context);
    loading = false;
  }

  Future<void> onDispose(BuildContext context) async {
    loading = true;
    var providerDetallesCrypto =
        Provider.of<DetalleCryptoProvider>(context, listen: false);
    providerDetallesCrypto.cleanList();
    channel.sink.close();
    _navigationService.pop();
    loading = false;
    //IOWebSocketChannel._navigationService.pop();
  }

  webSocket(BuildContext context) {
    var providerDetallesCrypto =
        Provider.of<DetalleCryptoProvider>(context, listen: false);
    try {
      channel.stream.listen((message) {
        var getData = jsonDecode(message);
        crypto = CryptoData(
            symbol: getData['s'].toString().replaceAll("USDT", ""),
            precio: double.parse(getData['c']),
            alto: double.parse(getData['h']),
            bajo: double.parse(getData['l']),
            volumenCuota: double.parse(getData['q']),
            cambioPrecio: double.parse(getData['p']),
            porcentaje: double.parse(getData['P']),
            volumen: double.parse(getData['v']));

        providerDetallesCrypto.setCrypto(crypto: crypto);
        providerDetallesCrypto.addSpotToList(
          spot: BarChartGroupData(
            x: providerDetallesCrypto.last10.length,
            barRods: [
              BarChartRodData(
                toY: crypto.precio,
                gradient: const LinearGradient(
                  colors: [
                    AppColors.binanceYellow,
                    AppColors.binanceBlack,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              )
            ],
            showingTooltipIndicators: [0],
          ),
        );
        notifyListeners();
      }, onError: (error) {
        Dialogs.error(msg: "Error al consumir el api de binance");
      });
    } catch (e) {
      Dialogs.error(msg: "Error al consumir el api de binance");
    }
  }
}
