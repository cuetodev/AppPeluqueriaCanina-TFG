import 'dart:convert';

import 'package:tfg_front_app/models/client_model.dart';

import '../ip_config.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<dynamic> register(
      String userName, String email, String password) async {
    String ip = IpConfig.ip;

    final response = await http.post(Uri.parse("http://$ip:8080/api/v0/client"),
        headers: {"Content-type": "application/json"},
        body: json.encode(
            {"userName": userName, "email": email, "password": password}));

    if (response.statusCode == 200) {
      return Client.fromMap(json.decode(response.body));
    } else {
      return "Credenciales incorrectas";
    }
  }

  static Future<dynamic> login(String email, String password) async {
    String ip = IpConfig.ip;

    final queryParams = {"email": email, "password": password};

    final uri = Uri.http("$ip:8080", "/api/v0/client/login", queryParams);
    final response =
        await http.get(uri, headers: {"Content-type": "application/json"});

    if (response.statusCode == 200) {
      return Client.fromMap(json.decode(response.body));
    } else {
      return "Credenciales incorrectas";
    }
  }

  static Future<dynamic> getToken(String email, String password) async {
    String ip = IpConfig.ip;

    final queryParams = {"email": email.trim(), "password": password.trim()};

    final uri = Uri.http("$ip:8080", "/api/v0/client/token", queryParams);
    final response =
        await http.get(uri, headers: {"Content-type": "application/json"});

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Credenciales incorrectas";
    }
  }
}
