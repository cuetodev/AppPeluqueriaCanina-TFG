import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_front_app/pages/contact_page.dart';
import 'package:tfg_front_app/pages/appointment_page.dart';
import 'package:tfg_front_app/pages/login_page.dart';
import 'package:tfg_front_app/pages/signup_page.dart';

import 'pages/intro_page.dart';
import 'pages/perfil_page.dart';
import 'pages/pet_add_page.dart';
import 'pages/pet_page.dart';
import 'pages/splashscreen_page.dart';
import 'pages/staff_appointment_search_page.dart';
import 'pages/staff_page.dart';
import 'providers/general_provider.dart';
import 'user_preferences/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _prefs = PreferenciasUsuario();
  await _prefs.initPrefs();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GeneralProvider(),
          lazy: false,
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DogGroomerApp",
      debugShowCheckedModeBanner: false,
      initialRoute: 'splashscreen_page',
      routes: {
        'splashscreen_page': (_) => const SplashScreenPage(),
        'intro_page': (_) => IntroPage(),
        'login_page': (_) => LoginPage(),
        'register_page': (_) => RegisterPage(),
        'perfil_page': (_) => PerfilPage(),
        'contact_page': (_) => ContactPage(),
        'pet_page': (_) => PetPage(),
        'pet_add_page': (_) => PetAddPage(),
        'appointment_page': (_) => AppointmentPage(),
        'staff_page': (_) => StaffPage(),
        'staff_appointment_search_page': (_) => StaffAppointmentSearchPage()
      },
    );
  }
}
