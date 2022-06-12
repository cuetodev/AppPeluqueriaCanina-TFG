// To parse this JSON data, do
//
//     final client = clientFromMap(jsonString);

import 'dart:convert';

import 'pet_model.dart';

Client clientFromMap(String str) => Client.fromMap(json.decode(str));

String clientToMap(Client data) => json.encode(data.toMap());

class Client {
    Client({
        this.id,
        this.userName,
        this.email,
        this.password,
        this.role,
        this.active,
        this.pets,
    });

    int? id;
    String? userName;
    String? email;
    String? password;
    String? role;
    bool? active;
    List<Pet>? pets;

    factory Client.fromMap(Map<String, dynamic> json) => Client(
        id: json["id"],
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        active: json["active"],
        pets: List<Pet>.from(json["pets"].map((x) => Pet.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "userName": userName,
        "email": email,
        "password": password,
        "role": role,
        "active": active,
        "pets": List<dynamic>.from(pets!.map((x) => x.toMap())),
    };
}