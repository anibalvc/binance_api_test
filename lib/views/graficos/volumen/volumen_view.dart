library volumen_view;

import 'package:binance_api_test/widgets/app_circle_chart.dart';
import 'package:binance_api_test/widgets/progress_widget.dart';
import 'package:binance_api_test/widgets/tap_to_hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'volumen_view_model.dart';

part 'volumen_mobile.dart';

class VolumenView extends StatelessWidget {
  static const routeName = 'volumen';
  const VolumenView({super.key});

  @override
  Widget build(BuildContext context) {
    VolumenViewModel viewModel = VolumenViewModel();
    return ViewModelBuilder<VolumenViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onViewModelReady: (viewModel) => viewModel.onInit(context),
        /* onDispose: (viewModel) => viewModel.onDispose(context), */
        builder: (context, viewModel, child) {
          return _VolumenMobile(viewModel);
        });
  }
}
