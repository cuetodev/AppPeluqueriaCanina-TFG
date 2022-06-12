import 'dart:convert';
import 'dart:io';

import '../ip_config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

import '../models/client_model.dart';
import '../models/pet_model.dart';

class PetService {
  static Future<Pet> savePet(String name, String breed, String type,
      double weight, File? image, String token, Client client) async {
    String ip = IpConfig.ip;
    Map<String, String> pet = {};

    if (client.id != -5) {
      var headers = {'Authorization': 'Client-ID 7900ece629b81ef'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://api.imgur.com/3/upload'));

      var imagePick = await http.MultipartFile.fromPath('image', image!.path);

      request.files.add(imagePick);

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var imgurResponse = jsonDecode(await response.stream.bytesToString());

      pet = {
        "name": name,
        "breed": breed,
        "type": type,
        "weight": weight.toString(),
        "img": imgurResponse["data"]["link"],
        "client_id": client.id.toString()
      };
    } else {
      pet = {
        "name": name,
        "breed": breed,
        "type": type,
        "weight": weight.toString(),
      };
    }

    var resp = await http.post(Uri.parse('http://$ip:8080/api/v0/pet'),
        headers: {"Content-type": "application/json", "Authorization": token},
        body: json.encode(pet));

    return petFromMap(resp.body);
  }

  static Future<List<dynamic>> getMyPets(int clientId, String token) async {
    String ip = IpConfig.ip;

    final response = await http.get(
        Uri.parse('http://$ip:8080/api/v0/pet/$clientId/all'),
        headers: {"Content-type": "application/json", "Authorization": token});

    return json.decode(response.body)["content"];
  }

  static Future<int> deletePetById(int petId, String token) async {
    String ip = IpConfig.ip;

    final response = await http.delete(
        Uri.parse('http://$ip:8080/api/v0/pet/$petId'),
        headers: {"Content-type": "application/json", "Authorization": token});

    return response.statusCode;
  }
}
