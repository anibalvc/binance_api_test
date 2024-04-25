library create_account_view;

import 'package:binance_api_test/core/utils/validators.dart';
import 'package:binance_api_test/theme/theme.dart';
import 'package:binance_api_test/views/auth/widgets/create_account_page_widget.dart';
import 'package:binance_api_test/widgets/app_buttons.dart';
import 'package:binance_api_test/widgets/app_textfield.dart';
import 'package:binance_api_test/widgets/progress_widget.dart';
import 'package:binance_api_test/widgets/tap_to_hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../widgets/app_obscure_text_icon.dart';
import 'create_account_view_model.dart';

part 'create_account_mobile.dart';

class CreateAccountView extends StatelessWidget {
  static const routeName = 'create-account';
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    CreateAccountViewModel viewModel = CreateAccountViewModel();
    return ViewModelBuilder<CreateAccountViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onViewModelReady: (viewModel) {
          // Do something once your viewModel is initialized
        },
        builder: (context, viewModel, child) {
          return _CreateAccountMobile(viewModel);
        });
  }
}
