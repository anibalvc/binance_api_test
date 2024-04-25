import 'dart:convert';

UsuariosResponse usuariosResponseFromJson(String str) =>
    UsuariosResponse.fromList(json.decode(str));

String usuariosResponseToJson(UsuariosResponse data) =>
    json.encode(data.toJson());

class UsuariosResponse {
  UsuariosResponse({
    required this.data,
  });

  List<UsuariosData> data;

  factory UsuariosResponse.fromList(List<dynamic> list) => UsuariosResponse(
        data: list.map<UsuariosData>((e) => UsuariosData.fromJson(e)).toList(),
      );

  factory UsuariosResponse.fromJson(Map<String, dynamic> json) =>
      UsuariosResponse(
        data: json["data"]
            .map<UsuariosData>((e) => UsuariosData.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "data": data.map((e) => e.toJson()),
      };
}

class UsuariosData {
  UsuariosData(
      {required this.id,
      required this.loginUsuario,
      required this.nombrePerfil,
      required this.correo,
      required this.imgPerfil,
      required this.password});

  int id;
  String loginUsuario;
  String nombrePerfil;
  String correo;
  String imgPerfil;
  String password;

  factory UsuariosData.fromJson(Map<String, dynamic> json) => UsuariosData(
      id: json["id"] ?? 0,
      loginUsuario: json["loginUsuario"] ?? '',
      nombrePerfil: json["nombrePerfil"] ?? '',
      imgPerfil: json["imgPerfil"] ?? '',
      correo: json["correo"] ?? "",
      password: json["password"] ?? "");

  Map<String, dynamic> toJson() => {
        "id": id,
        "loginUsuario": loginUsuario,
        "nombrePerfil": nombrePerfil,
        "imgPerfil": imgPerfil,
        "correo": correo,
        "password": password,
      };
}
