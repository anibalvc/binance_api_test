import 'package:binance_api_test/core/api/core/http.dart';
import 'package:binance_api_test/core/models/usuarios_response.dart';

class AuthenticationApi {
  final Http _http;
  AuthenticationApi(this._http);

  Future<Object> signIn({
    required String usuario,
    required String clave,
  }) {
    return _http.request(
      '/login',
      method: 'POST',
      data: {
        "usuario": usuario,
        "clave": clave,
      },
      parser: (data) {
        return UsuariosData.fromJson(data);
      },
    );
  }

  Future<Object> createUser(
      {required String usuario,
      required String clave,
      required String nombrePerfil,
      required String correo,
      required String rol,
      String? nombreEquipo,
      int? idRegion,
      int? idDeporte}) {
    Map<String, dynamic> usuarioCreate;
    usuarioCreate = {
      "usuario": {
        "usuario": usuario,
        "clave": clave,
        "nombrePerfil": nombrePerfil,
        "correo": correo,
        "rol": rol
      }
    };
    if (rol == "Equipo") {
      usuarioCreate.addAll({
        "equipo": {
          "idUsuario": 0,
          "idDeportesElectronicos": idDeporte,
          "Regiones_idRegiones": idRegion,
          "nombre": nombreEquipo
        }
      });
    }
    return _http.request(
      '/crear-usuario',
      method: 'POST',
      data: usuarioCreate,
    );
  }
}
