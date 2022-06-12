import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  // Singleton
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get idClient {
    return _prefs.getString('idClient') ?? 'noIdClient';
  }

  set idClient(String idClient) {
    _prefs.setString('idClient', idClient);
  }

  String get token {
    return _prefs.getString('token') ?? 'notoken';
  }

  set token(String token) {
    _prefs.setString('token', token);
  }
}
