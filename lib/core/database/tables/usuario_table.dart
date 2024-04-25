import 'package:binance_api_test/core/database/database_service.dart';
import 'package:binance_api_test/core/models/usuarios_response.dart';
import 'package:binance_api_test/widgets/app_dialogs.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioDB {
  final tableName = 'usuarios';

  Future<void> crearTabla(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
    "id" INTEGER NOT NULL,
    "loginUsuario" TEXT NOT NULL,
    "nombrePerfil" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "correo" TEXT NOT NULL,
    "imgPerfil" LONGTEXT,
    PRIMARY KEY("id" AUTOINCREMENT)
    );""");
  }

  Future<int> insert({required UsuariosData usuario}) async {
    final database = await DatabaseService().database;
    if (database.isOpen) {
      var usuarios = await selectAll();
      if (usuarios.data.any((usuarioX) => usuarioX.correo == usuario.correo)) {
        Dialogs.error(msg: "Correo existente");
        return -1;
      }
      if (usuarios.data
          .any((usuarioX) => usuarioX.loginUsuario == usuario.loginUsuario)) {
        Dialogs.error(msg: "Usuario existente");
        return -1;
      }
    }
    return await database.rawInsert(
        """INSERT INTO $tableName (loginUsuario, nombrePerfil, correo, imgPerfil, password) VALUES (?,?,?,?,?)""",
        [
          usuario.loginUsuario,
          usuario.nombrePerfil,
          usuario.correo,
          usuario.imgPerfil,
          usuario.password
        ]);
  }

  Future<UsuariosResponse> selectAll() async {
    final database = await DatabaseService().database;
    final usuarios = await database.rawQuery(""" SELECT * from $tableName""");
    return UsuariosResponse.fromList(usuarios);
  }

  Future<int> update(
      {required int id,
      String? nombrePerfil,
      String? correo,
      String? imgPerfil,
      String? password}) async {
    final database = await DatabaseService().database;
    Map<String, dynamic> usuarioCambios = {
      if (nombrePerfil != null) "nombrePerfil": nombrePerfil,
      if (correo != null) "correo": correo,
      if (imgPerfil != null) "imgPerfil": imgPerfil,
      if (password != null) "password": password
    };
    return await database.update(tableName, usuarioCambios,
        where: "id=?",
        conflictAlgorithm: ConflictAlgorithm.rollback,
        whereArgs: [id]);
  }

  Future<void> deleteAllInfo() async {
    final database = await DatabaseService().database;
    await database.rawDelete("""DELETE FROM $tableName""");
  }

  Future<void> deleteTable() async {
    final database = await DatabaseService().database;
    await database.rawDelete("""DROP TABLE $tableName""");
  }
}
