// To parse this JSON data, do
//
//     final pet = petFromMap(jsonString);

import 'dart:convert';

import 'dart:io';

Pet petFromMap(String str) => Pet.fromMap(json.decode(str));

String petToMap(Pet data) => json.encode(data.toMap());

class Pet {
  Pet({
    this.id,
    this.name,
    this.breed,
    this.type,
    this.weight,
    this.img,
    this.clientId,
  });

  int? id;
  String? name;
  String? breed;
  String? type;
  double? weight;
  String? img;
  int? clientId;

  factory Pet.fromMap(Map<String, dynamic> json) => Pet(
        id: json["id"],
        name: json["name"],
        breed: json["breed"],
        type: json["type"],
        weight: json["weight"],
        img: json["img"],
        clientId: json["clientId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "breed": breed,
        "type": type,
        "weight": weight,
        "img": img,
        "clientId": clientId,
      };
}
