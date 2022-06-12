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

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _advancedDrawerController = AdvancedDrawerController();

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
                    image: AssetImage("assets/contact_background.jpg"),
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
                left: size.width * 0.15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contacta con nosotr@s",
                      style: GoogleFonts.prompt(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 25,
                            color: Color(0xFF386057),
                            letterSpacing: .5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 72, left: 40),
                      child: Container(
                        height: size.height * 0.09,
                        width: size.width * 0.6,
                        decoration: BoxDecoration(
                          color: Color(0xFF386057),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              offset: Offset(0.0, 10.0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40, top: 15),
                          child: Text(
                            "Parque Manuel Carrasco,   S/N, 23600 Martos, Jaén",
                            style: GoogleFonts.prompt(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                  color: Colors.white,
                                  letterSpacing: .5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 92, left: 40),
                      child: Container(
                        height: size.height * 0.09,
                        width: size.width * 0.6,
                        decoration: BoxDecoration(
                          color: Color(0xFF386057),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              offset: Offset(0.0, 10.0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40, top: 25),
                          child: Text(
                            "doggrooming@gmail.com",
                            style: GoogleFonts.prompt(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                  color: Colors.white,
                                  letterSpacing: .5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 102, left: 40),
                      child: Container(
                        height: size.height * 0.09,
                        width: size.width * 0.6,
                        decoration: BoxDecoration(
                          color: Color(0xFF386057),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              offset: Offset(0.0, 10.0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40, top: 25),
                          child: Text(
                            "+34 629123123",
                            style: GoogleFonts.prompt(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                  color: Colors.white,
                                  letterSpacing: .5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: size.height * 0.305,
                left: size.width * 0.19,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF386057),
                    borderRadius: BorderRadius.circular(90.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Icon(Icons.location_pin, color: Colors.white),
                ),
              ),
              Positioned(
                top: size.height * 0.511,
                left: size.width * 0.19,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF386057),
                    borderRadius: BorderRadius.circular(90.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Icon(Icons.email_rounded, color: Colors.white),
                ),
              ),
              Positioned(
                top: size.height * 0.731,
                left: size.width * 0.19,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF386057),
                    borderRadius: BorderRadius.circular(90.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Icon(Icons.phone, color: Colors.white),
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
