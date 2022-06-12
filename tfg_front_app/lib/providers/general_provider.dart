import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/client_model.dart';
import '../models/pet_model.dart';

class GeneralProvider extends ChangeNotifier {
  Client client = Client(id: -5);
  String token = '';

  Pet selectedPetForAppointment = Pet(id: -5);

  setClient(Client clientReceived) {
    client = clientReceived;
    notifyListeners();
  }

  setPet(Pet petReceived) {
    selectedPetForAppointment = petReceived;
    notifyListeners();
  }

  setToken(String tokenReceived) {
    token = tokenReceived;
    notifyListeners();
  }

  updateUserName(String userName) {
    client.userName = userName;
    notifyListeners();
  }

  updatePassword(String password) {
    client.password = password;
    notifyListeners();
  }

  updateToken(String tokenReceived) {
    token = tokenReceived;
    notifyListeners();
  }
}
