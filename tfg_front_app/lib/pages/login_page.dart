import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tfg_front_app/services/auth_service.dart';

import '../components/background.dart';
import '../models/client_model.dart';
import '../providers/general_provider.dart';
import '../user_preferences/user_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _pass = '';
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    GeneralProvider generalProvider = Provider.of<GeneralProvider>(context);
    final _prefs = PreferenciasUsuario();
    Client client = generalProvider.client;
    return AdvancedDrawer(
      backdropColor: Color.fromARGB(255, 56, 97, 87),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Background(
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50, bottom: 80, right: 300),
                  child: IconButton(
                    onPressed: _handleMenuButtonPressed,
                    icon: ValueListenableBuilder<AdvancedDrawerValue>(
                      valueListenable: _advancedDrawerController,
                      builder: (_, value, __) {
                        return AnimatedSwitcher(
                          duration: Duration(milliseconds: 250),
                          child: Icon(
                            value.visible ? Icons.clear : Icons.menu,
                            key: ValueKey<bool>(value.visible),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: const Text(
                    "Inicia Sesión",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF386057),
                        fontSize: 36),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Correo",
                        labelStyle: TextStyle(
                          color: Color(0xFF386057),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF386057),
                          ),
                        ),
                      ),
                      cursorColor: const Color(0xFF386057),
                      onChanged: (value) {
                        setState(() {
                          _email = value.toLowerCase();
                        });
                      }),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Contraseña",
                      labelStyle: TextStyle(
                        color: Color(0xFF386057),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF386057),
                        ),
                      ),
                    ),
                    cursorColor: const Color(0xFF386057),
                    onChanged: (value) {
                      setState(() {
                        _pass = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: RaisedButton(
                    onPressed: () async {
                      final resp = await AuthService.login(_email, _pass);

                      if (resp == "Credenciales incorrectas") {
                        Alert(
                          context: context,
                          type: AlertType.error,
                          title: "Credenciales incorrectas",
                          desc: "Revisa tu correo y tu email.",
                          buttons: [
                            DialogButton(
                              color: Color(0xFF386057),
                              child: Text(
                                "Continuar",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                        // Si el logueo es correcto
                      } else {
                        // Meto el usuario y el token en el provider y redirecciono
                        generalProvider.setClient(resp);
                        _prefs.idClient = jsonEncode(resp.toMap());
                        String token = await AuthService.getToken(
                            resp.email!, resp.password!);
                        generalProvider.setToken(token);
                        _prefs.token = token;
                        Navigator.pushReplacementNamed(context, 'intro_page');
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(255, 255, 136, 34),
                            Color.fromARGB(255, 255, 177, 41)
                          ])),
                      padding: const EdgeInsets.all(0),
                      child: const Text(
                        "Inicia Sesión",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pushReplacementNamed(context, "register_page")
                    },
                    child: const Text(
                      "¿Aún no tienes una cuenta? Regístrate",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF386057)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 148.0,
                  height: 148.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.white70,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "intro_page");
                  },
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, "appointment_page");
                  },
                  leading: Icon(Icons.people_sharp),
                  title: Text('Citas'),
                ),
                ListTile(
                  onTap: () {
                    if (client.id == -5) {
                      Alert(
                        context: context,
                        type: AlertType.info,
                        desc: "Inicia sesión para acceder a tus mascotas",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Regístrate",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, 'register_page'),
                            color: Color(0xFF2196F3),
                          ),
                          DialogButton(
                            child: Text(
                              "Inicia Sesión",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, 'login_page'),
                            color: Color(0xFF2196F3),
                          )
                        ],
                      ).show();
                    } else {
                      Navigator.pushReplacementNamed(context, "pet_page");
                    }
                  },
                  leading: client.id == -5
                      ? Icon(Icons.pets, color: Color(0xFFABB2BF))
                      : Icon(Icons.pets),
                  title: client.id == -5
                      ? Text('Mascotas',
                          style: TextStyle(color: Color(0xFFABB2BF)))
                      : Text('Mascotas'),
                ),
                ListTile(
                  onTap: () {
                    if (client.id == -5) {
                      Alert(
                        context: context,
                        type: AlertType.info,
                        desc: "Inicia sesión para acceder a tu perfil",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Regístrate",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, 'register_page'),
                            color: Color(0xFF2196F3),
                          ),
                          DialogButton(
                            child: Text(
                              "Inicia Sesión",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, 'login_page'),
                            color: Color(0xFF2196F3),
                          )
                        ],
                      ).show();
                    } else {
                      Navigator.pushReplacementNamed(context, "pet_page");
                    }
                  },
                  leading: client.id == -5
                      ? Icon(Icons.person, color: Color(0xFFABB2BF))
                      : Icon(Icons.person),
                  title: client.id == -5
                      ? Text('Perfil',
                          style: TextStyle(color: Color(0xFFABB2BF)))
                      : Text('Perfil'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "contact_page");
                  },
                  leading: Icon(Icons.contact_support_rounded),
                  title: Text('Contacto'),
                ),
                (client.id != -5 &&
                        (client.role == "ROLE_WORKER" ||
                            client.role == "ROLE_ADMIN"))
                    ? ListTile(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "staff_page");
                        },
                        leading: Icon(Icons.admin_panel_settings_sharp),
                        title: Text('Staff'),
                      )
                    : Container(),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: client.id == -5
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, "login_page");
                                },
                                child: Text(
                                  "Iniciar Sesión",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Text(
                                "|",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, "register_page");
                                },
                                child: Text(
                                  "Registrarse",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          )
                        : GestureDetector(
                            onTap: () {
                              _prefs.idClient = "noIdClient";
                              generalProvider.setClient(Client(id: -5));
                              Navigator.pushReplacementNamed(
                                  context, "intro_page");
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Icon(Icons.logout_rounded,
                                      color: Colors.white),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Cerrar sesión",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
