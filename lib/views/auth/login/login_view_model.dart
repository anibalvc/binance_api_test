import 'package:binance_api_test/core/authentication_client.dart';
import 'package:binance_api_test/core/base/base_view_model.dart';
import 'package:binance_api_test/core/database/tables/usuario_table.dart';
import 'package:binance_api_test/core/locator.dart';
import 'package:binance_api_test/core/models/usuarios_response.dart';
import 'package:binance_api_test/core/services/navigator_service.dart';
import 'package:binance_api_test/views/home/home_view.dart';
import 'package:binance_api_test/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigatorService>();
  final _autenticationClient = locator<AuthenticationClient>();
  final GlobalKey<FormState> formKey = GlobalKey();
  final usuarioDB = UsuarioDB();

  bool _loading = false;
  TextEditingController tcEmail = TextEditingController();
  TextEditingController tcPassword = TextEditingController();
  bool obscurePassword = true;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> signIn(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      loading = true;
      var usuarios = await usuarioDB.selectAll();
      UsuariosData? usuario;
      usuario = usuarios.data.firstWhere(
        (usuario) => ((usuario.correo == tcEmail.text ||
                usuario.loginUsuario == tcEmail.text) &&
            usuario.password == tcPassword.text),
        orElse: () => UsuariosData(
            id: 0,
            loginUsuario: "",
            nombrePerfil: "",
            correo: "",
            imgPerfil: "",
            password: ""),
      );
      if (usuario.id != 0) {
        _autenticationClient.saveUsuario(usuario);
        _autenticationClient.isLogged = true;
        _navigationService.navigateToPageWithReplacement(HomeView.routeName);
      } else {
        Dialogs.error(
            msg: "No se encuentra esa combinación de usuario y contraseña");
      }
      loading = false;
    }
  }

  void changeObscure() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  /*  void goToRecoveryPassword() {
    _navigationService.navigateToPage(RecoveryPasswordView.routeName);
  } */

  @override
  void dispose() {
    tcEmail.dispose();
    tcPassword.dispose();
    super.dispose();
  }
}
