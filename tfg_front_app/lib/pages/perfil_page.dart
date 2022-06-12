import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tfg_front_app/services/client_service.dart';

import '../models/client_model.dart';
import '../providers/general_provider.dart';
import '../services/auth_service.dart';
import '../user_preferences/user_preferences.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final _advancedDrawerController = AdvancedDrawerController();
  String _userName = '';
  String _pass = '';
  String _oldPass = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _prefs = PreferenciasUsuario();
    GeneralProvider generalProvider = Provider.of<GeneralProvider>(context);
    Client client = generalProvider.client;
    return AdvancedDrawer(
      backdropColor: Color.fromARGB(255, 56, 97, 87),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/perfil_background.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 45),
                child: IconButton(
                  onPressed: _handleMenuButtonPressed,
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: _advancedDrawerController,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 250),
                        child: Icon(
                          value.visible ? Icons.clear : Icons.menu,
                          color: Color(0xFF386057),
                          key: ValueKey<bool>(value.visible),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.15,
                left: size.width * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bienvenid@",
                      style: GoogleFonts.prompt(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 25,
                            color: Color(0xFF386057),
                            letterSpacing: .5),
                      ),
                    ),
                    Text(
                      "${client.userName}",
                      style: GoogleFonts.prompt(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                            color: Color(0xFF386057),
                            letterSpacing: .5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(
                        "Cambia tus datos aquí",
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: Color(0xFF386057),
                              letterSpacing: .1),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.5,
                      alignment: Alignment.center,
                      child: TextField(
                        maxLength: 20,
                        decoration: const InputDecoration(
                          labelText: "Nombre de usuario",
                          labelStyle: TextStyle(
                            color: Color(0xFF386057),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF386057),
                            ),
                          ),
                        ),
                        cursorColor: Color(0xFF386057),
                        onChanged: (value) {
                          _userName = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: size.width * 0.5,
                        alignment: Alignment.center,
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
                          cursorColor: Color(0xFF386057),
                          onChanged: (value) {
                            _pass = value;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(
                        "Coloca tu contraseña para confirmar",
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: Color(0xFF386057),
                              letterSpacing: .1),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.5,
                      alignment: Alignment.center,
                      child: TextField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Contraseña Antigua",
                          labelStyle: TextStyle(
                            color: Color(0xFF386057),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF386057),
                            ),
                          ),
                        ),
                        cursorColor: Color(0xFF386057),
                        onChanged: (value) {
                          _oldPass = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: MaterialButton(
                        onPressed: () async {
                          if (_oldPass == client.password) {
                            if (_userName == '' && _pass == '') {
                              Alert(
                                context: context,
                                type: AlertType.error,
                                desc: "No has actualizado nada",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Continuar",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ],
                              ).show();
                            } else {
                              String token = await AuthService.getToken(
                                  client.email!, client.password!);

                              if (_userName != '') {
                                generalProvider.updateUserName(_userName);
                                await ClientService.updateClient(
                                    client.id!, token,
                                    userName: _userName);
                              }
                              if (_pass != '') {
                                generalProvider.updatePassword(_pass);
                                await ClientService.updateClient(
                                    client.id!, token,
                                    password: _pass);
                              }

                              Alert(
                                context: context,
                                type: AlertType.success,
                                title: "Perfil actualizado correctamente",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Continuar",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () =>
                                        Navigator.pushReplacementNamed(
                                            context, "intro_page"),
                                    width: 120,
                                  )
                                ],
                              ).show();
                            }
                          } else {
                            Alert(
                              context: context,
                              type: AlertType.error,
                              title: "Contraseña errónea",
                              desc: "Revisa tu contraseña antigua",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Continuar",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  width: 120,
                                )
                              ],
                            ).show();
                          }
                        },
                        splashColor: Colors.white70,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Text(
                          'Actualizar',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        color: Color(0xFF386057),
                        height: 35,
                        minWidth: 190,
                      ),
                    )
                  ],
                ),
              ),
            ],
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
                  onTap: () {Navigator.pushNamed(context, "appointment_page");},
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
                      Navigator.pushReplacementNamed(context, "perfil_page");
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
