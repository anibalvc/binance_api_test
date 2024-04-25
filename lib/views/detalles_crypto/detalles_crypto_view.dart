library detalles_crypto_view;

import 'package:binance_api_test/core/providers/detalle_crypto_provider.dart';
import 'package:binance_api_test/widgets/app_individual_chart.dart';
import 'package:binance_api_test/widgets/progress_widget.dart';
import 'package:binance_api_test/widgets/tap_to_hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'detalles_crypto_view_model.dart';

part 'detalles_crypto_mobile.dart';

class DetallesCryptoView extends StatelessWidget {
  static const routeName = 'detalles-crypto';
  final String symbol;
  const DetallesCryptoView({super.key, required this.symbol});

  @override
  Widget build(BuildContext context) {
    var crypto =
        Provider.of<DetalleCryptoProvider>(context, listen: false).crypto;
    DetallesCryptoViewModel viewModel =
        DetallesCryptoViewModel(crypto: crypto, symbol: symbol);
    return ViewModelBuilder<DetallesCryptoViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onViewModelReady: (viewModel) => viewModel.onInit(context),
        onDispose: (viewModel) => viewModel.onDispose(context),
        builder: (context, viewModel, child) {
          return _DetallesCryptoMobile(viewModel);
        });
  }
}
