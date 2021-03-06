import 'dart:convert';
import 'dart:ui';

import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tfg_front_app/models/pet_model.dart';
import 'package:tfg_front_app/services/pet_service.dart';

import '../models/client_model.dart';
import '../providers/general_provider.dart';
import '../search/mypet_search.dart';
import '../services/auth_service.dart';
import '../user_preferences/user_preferences.dart';

class PetPage extends StatefulWidget {
  @override
  _PetPageState createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  final _advancedDrawerController = AdvancedDrawerController();
  Color primaryGreen = Color(0xff416d6d);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _prefs = PreferenciasUsuario();
    GeneralProvider generalProvider = Provider.of<GeneralProvider>(context);
    Client client = generalProvider.client;

    return AdvancedDrawer(
      backdropColor: const Color.fromARGB(255, 56, 97, 87),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
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
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                ),
                ListTile(
                  onTap: () {Navigator.pushNamed(context, "appointment_page");},
                  leading: const Icon(Icons.people_sharp),
                  title: const Text('Citas'),
                ),
                ListTile(
                  onTap: () {
                    if (client.id == -5) {
                      Alert(
                        context: context,
                        type: AlertType.info,
                        desc: "Inicia sesi??n para acceder a tus mascotas",
                        buttons: [
                          DialogButton(
                            child: const Text(
                              "Reg??strate",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, 'register_page'),
                            color: const Color(0xFF2196F3),
                          ),
                          DialogButton(
                            child: const Text(
                              "Inicia Sesi??n",
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
                      ? const Icon(Icons.pets, color: Color(0xFFABB2BF))
                      : const Icon(Icons.pets),
                  title: client.id == -5
                      ? const Text('Mascotas',
                          style: TextStyle(color: Color(0xFFABB2BF)))
                      : const Text('Mascotas'),
                ),
                ListTile(
                  onTap: () {
                    if (client.id == -5) {
                      Alert(
                        context: context,
                        type: AlertType.info,
                        desc: "Inicia sesi??n para acceder a tu perfil",
                        buttons: [
                          DialogButton(
                            child: const Text(
                              "Reg??strate",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, 'register_page'),
                            color: Color(0xFF2196F3),
                          ),
                          DialogButton(
                            child: const Text(
                              "Inicia Sesi??n",
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
                      ? const Icon(Icons.person, color: Color(0xFFABB2BF))
                      : const Icon(Icons.person),
                  title: client.id == -5
                      ? const Text('Perfil',
                          style: TextStyle(color: Color(0xFFABB2BF)))
                      : const Text('Perfil'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "contact_page");
                  },
                  leading: const Icon(Icons.contact_support_rounded),
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
                const Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(
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
                                child: const Text(
                                  "Iniciar Sesi??n",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const Text(
                                "|",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, "register_page");
                                },
                                child: const Text(
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
                            child: Row(
                              children: const [
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(Icons.logout_rounded, color: Colors.white),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Cerrar sesi??n",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // BACKGROUND IMAGE
      child: Container(
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/pets_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            // APP START
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
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
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.asset("assets/logo.png"),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: const LinearGradient(colors: [
                              Color(0xff386057),
                              Color(0xff15BE77)
                            ])),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                alignment: Alignment.center,
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.only(right: 75, left: 75)),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                )),
                            onPressed: () {
                              Navigator.pushNamed(context, 'pet_add_page');
                            },
                            child: const Text(
                              "A??ade una nueva mascota",
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/pet_add_background.jpg"),
                              fit: BoxFit.fill),
                          border: Border.all(color: Color(0xff386057)),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          )),
                      child: _crearLista(generalProvider, client, context),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearLista(
      GeneralProvider generalProvider, Client client, BuildContext context) {
    String token = '';
    token = generalProvider.token;

    return FutureBuilder(
      future: PetService.getMyPets(client.id!, token),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Agrega tu primera mascota :D",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF386257),
                ),
              ),
            );
          }

          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: FadingEdgeScrollView.fromSingleChildScrollView(
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, pos) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          snapshot.data![pos]["img"],
                                        ),
                                      ),
                                      color: Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff386057),
                                          Color(0xff15BE77)
                                        ],
                                      ),
                                    ),
                                    child: IconButton(
                                      splashColor: Colors.transparent,
                                      onPressed: () async {
                                        int code =
                                            await PetService.deletePetById(
                                                snapshot.data![pos]["id"],
                                                token);
                                        if (code == 200) {
                                          Alert(
                                            context: context,
                                            type: AlertType.success,
                                            title:
                                                "${snapshot.data![pos]['name']} eliminada correctamente",
                                            buttons: [
                                              DialogButton(
                                                child: const Text(
                                                  "Continuar",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () => Navigator
                                                    .pushReplacementNamed(
                                                        context, "pet_page"),
                                                width: 120,
                                              )
                                            ],
                                          ).show();
                                        } else {
                                          Alert(
                                            context: context,
                                            type: AlertType.error,
                                            desc:
                                                "No se ha podido borrar a ${snapshot.data![pos]['name']}",
                                            buttons: [
                                              DialogButton(
                                                child: const Text(
                                                  "Continuar",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () => Navigator
                                                    .pushReplacementNamed(
                                                        context, "pet_page"),
                                                width: 120,
                                              )
                                            ],
                                          ).show();
                                        }
                                      },
                                      icon: const Icon(Icons.close,
                                          size: 20, color: Colors.white),
                                    ),
                                  ),
                                  Positioned(
                                    top: 110,
                                    left: 117,
                                    child: Container(
                                      height: 40,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff386057),
                                            Color(0xff15BE77)
                                          ],
                                        ),
                                      ),
                                      child: TextButton(
                                        style: const ButtonStyle(
                                          splashFactory: NoSplash.splashFactory,
                                        ),
                                        onPressed: () {
                                          Map<String, dynamic> petMap =
                                              snapshot.data![pos];
                                          Pet pet =
                                              petFromMap(json.encode(petMap));
                                          generalProvider.setPet(pet);
                                          Navigator.pushNamed(
                                              context, 'appointment_page');
                                        },
                                        child: const Text("Cita",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xff386057),
                                    Color(0xff15BE77)
                                  ]),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, bottom: 5),
                                        child: Text(
                                          snapshot.data![pos]["name"],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 10),
                                        child: Text(
                                          snapshot.data![pos]["breed"],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 10),
                                        child: Text(
                                          snapshot.data![pos]["weight"]
                                                  .toString() +
                                              " KG",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF386359),
          ),
        );
      },
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
