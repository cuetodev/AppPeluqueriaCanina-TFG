import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tfg_front_app/models/appointment_model.dart';

import '../ip_config.dart';
import 'package:http/http.dart' as http;

class AppointmentService {
  static String ip = IpConfig.ip;

  static Future<List<String>> getTimesByDate(String date, String token) async {
    final queryParams = {"date": date};

    final uri = Uri.http("$ip:8080", "/api/v0/appointment/times", queryParams);
    final response = await http.get(uri,
        headers: {"Content-type": "application/json", "Authorization": token});

    List<String> times = [];
    List<dynamic> responseReceived = jsonDecode(response.body);

    responseReceived.forEach((element) {
      times.add(element.toString());
    });
    return times;
  }

  static Future<int> saveAppointment(Appointment appointment) async {
    appointment.status ?? (appointment.status = "active");

    Map<String, String> appointmentMap = {
      "date": appointment.date.toString(),
      "hourCheck": appointment.hourCheck.toString(),
      "services": appointment.services.toString(),
      "phone": appointment.phone.toString(),
      "petId": appointment.pet.toString(),
      "status": appointment.status.toString()
    };

    final response = await http.post(
      Uri.parse("http://$ip:8080/api/v0/appointment"),
      headers: {"Content-type": "application/json"},
      body: json.encode(appointmentMap),
    );

    return response.statusCode;
  }

  static Future<List<dynamic>> getAppointments(
      String date, String token) async {
    final queryParams = {"lowerDate": date};

    final uri = Uri.http("$ip:8080", "/api/v0/appointment/all", queryParams);
    final response = await http.get(uri,
        headers: {"Content-type": "application/json", "Authorization": token});

    return json.decode(response.body)["content"];
  }

  static Future<int> finishAppointment(int appointmentId, String token) async {
    Map<String, String> appointmentMap = {"status": "finished"};

    final response = await http.put(
      Uri.parse("http://$ip:8080/api/v0/appointment/$appointmentId"),
      headers: {"Content-type": "application/json", "Authorization": token},
      body: json.encode(appointmentMap),
    );

    return response.statusCode;
  }
}
