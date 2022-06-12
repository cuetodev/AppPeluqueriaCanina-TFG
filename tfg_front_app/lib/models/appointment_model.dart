// To parse this JSON data, do
//
//     final appointment = appointmentFromMap(jsonString);

import 'dart:convert';

import 'pet_model.dart';

Appointment appointmentFromMap(String str) =>
    Appointment.fromMap(json.decode(str));

String appointmentToMap(Appointment data) => json.encode(data.toMap());

class Appointment {
  Appointment({
    this.id,
    this.date,
    this.hourCheck,
    this.services,
    this.phone,
    this.status,
    this.pet,
  });

  int? id;
  String? date;
  String? hourCheck;
  String? services;
  String? phone;
  String? status;
  int? pet;

  factory Appointment.fromMap(Map<String, dynamic> json) => Appointment(
        id: json["id"],
        date: json["date"],
        hourCheck: json["hourCheck"],
        services: json["services"],
        phone: json["phone"],
        status: json["status"],
        pet: json["pet"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "date": date,
        "hourCheck": hourCheck,
        "services": services,
        "phone": phone,
        "status": status,
        "pet": pet,
      };
}
