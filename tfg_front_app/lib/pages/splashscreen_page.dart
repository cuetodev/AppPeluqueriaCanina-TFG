import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tfg_front_app/models/client_model.dart';

import '../../providers/general_provider.dart';
import '../../user_preferences/user_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final _prefs = PreferenciasUsuario();
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      GeneralProvider generalProvider =
          Provider.of<GeneralProvider>(context, listen: false);

      if (_prefs.idClient != "noIdClient") {
        generalProvider.setClient(Client.fromMap(json.decode(_prefs.idClient)));
      }
      if (_prefs.token != "notoken") {
        generalProvider.setToken(_prefs.token);
      }
    });
    super.initState();
    _cuentaAtras();
  }

  _cuentaAtras() {
    return Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(context, 'intro_page');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(color: Color(0xff5d9b9b)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(90))),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(45)),
                        child: Image.asset("assets/logo.png"),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
