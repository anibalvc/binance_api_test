import 'package:binance_api_test/core/base/base_view_model.dart';
import 'package:binance_api_test/core/database/tables/usuario_table.dart';
import 'package:binance_api_test/core/locator.dart';
import 'package:binance_api_test/core/models/usuarios_response.dart';
import 'package:binance_api_test/core/services/navigator_service.dart';
import 'package:binance_api_test/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';

class CreateAccountViewModel extends BaseViewModel {
  final _navigationService = locator<NavigatorService>();
  final GlobalKey<FormState> formKey = GlobalKey();
  final usuarioDB = UsuarioDB();

  bool _loading = false;
  TextEditingController tcNombreUsuario = TextEditingController();
  TextEditingController tcNombrePerfil = TextEditingController();
  TextEditingController tcCorreo = TextEditingController();
  TextEditingController tcPassword = TextEditingController();
  TextEditingController tcPassword2 = TextEditingController();
  bool obscurePassword = true;
  bool obscurePassword2 = true;
  bool checked = false;
  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> createAccount(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (checked) {
        try {
          loading = true;
          UsuariosData nuevoUsuario = UsuariosData(
              id: 0,
              loginUsuario: tcNombreUsuario.text,
              nombrePerfil: tcNombrePerfil.text,
              correo: tcCorreo.text,
              password: tcPassword.text,
              imgPerfil: "");
          var resp = await usuarioDB.insert(usuario: nuevoUsuario);
          if (resp > 0) {
            Dialogs.success(msg: "Cuenta creade exitosamente");
            _navigationService.pop();
          }
        } catch (e) {
          Dialogs.error(msg: "Error al crear cuenta");
        }
      } else {
        Dialogs.error(msg: "Debe aceptar los terminos y condiciones");
      }
      loading = false;
    }
  }

  void checkTerminos() {
    checked = !checked;
    notifyListeners();
  }

  void changeObscure() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void changeObscure2() {
    obscurePassword2 = !obscurePassword2;
    notifyListeners();
  }

  /*  void goToRecoveryPassword() {
    _navigationService.navigateToPage(RecoveryPasswordView.routeName);
  } */

  @override
  void dispose() {
    tcCorreo.dispose();
    tcPassword.dispose();
    super.dispose();
  }
}
