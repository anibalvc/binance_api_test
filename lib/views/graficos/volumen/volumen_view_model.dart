import 'package:binance_api_test/core/base/base_view_model.dart';
import 'package:binance_api_test/core/models/ticker_24h_response.dart';
import 'package:binance_api_test/core/models/usuarios_response.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class VolumenViewModel extends BaseViewModel {
  /*  final _authenticationClient = locator<AuthenticationClient>(); */
  final listController = ScrollController();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  bool _loading = false;

  final logger = Logger();

  late int idBarco = 0;
  late UsuariosData usuario;
  int tipoBarcoSelected = 0;
  List<Ticker24hData> tickets = [];

  VolumenViewModel();

  GlobalKey<ScaffoldState> get drawerKey => _drawerKey;

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> onInit(BuildContext context) async {}

  /* Future<void> onDispose(BuildContext context) async {
    loading = true;
    var providerDetallesCrypto =
        Provider.of<DetalleCryptoProvider>(context, listen: false);
    providerDetallesCrypto.cleanList();
    channel.sink.close();
    _navigationService.pop();
    loading = false;
    //IOWebSocketChannel._navigationService.pop();
  }
 */
  /*  dataStream(BuildContext context) {
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
      print(e);
    }
  } */
}
