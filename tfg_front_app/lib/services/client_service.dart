import 'dart:convert';

import '../ip_config.dart';
import 'package:http/http.dart' as http;

import '../models/client_model.dart';

class ClientService {
  static Future<dynamic> getClientByID(int id) async {
    String ip = IpConfig.ip;

    final uri = Uri.http("$ip:8080", "/api/v0/client/$id");
    final response =
        await http.get(uri, headers: {"Content-type": "application/json"});

    if (response.statusCode == 200) {
      return Client.fromMap(json.decode(response.body));
    } else {
      return "Credenciales incorrectas";
    }
  }

  static Future<dynamic> updateClient(int id, String token,
      {String userName = 'no',
      String password = 'no',
      String role = 'no'}) async {
    String ip = IpConfig.ip;

    final conditions = <String, dynamic>{};
    if (userName != 'no') conditions.addAll({'userName': userName});
    if (password != 'no') conditions.addAll({'password': password});
    if (role != 'no') conditions.addAll({'role': role});

    final uri = Uri.http("$ip:8080", "/api/v0/client/$id");
    final response = await http.put(uri,
        headers: {"Content-type": "application/json", "Authorization": token},
        body: json.encode(conditions));
  }

}
