import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tfg_front_app/services/client_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:tfg_front_app/services/pet_service.dart';

import '../models/client_model.dart';
import '../models/pet_model.dart';
import '../providers/general_provider.dart';
import '../services/auth_service.dart';
import '../user_preferences/user_preferences.dart';

class PetAddPage extends StatefulWidget {
  @override
  _PetAddPageState createState() => _PetAddPageState();
}

class _PetAddPageState extends State<PetAddPage> {
  File? image;
  Future pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image');
    }
  }

  final _advancedDrawerController = AdvancedDrawerController();
  String _petName = '';
  String _petBreed = '';
  String _type = '';
  double _petWeight = 0;

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
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            repeat: ImageRepeat.repeatY,
            image: AssetImage("assets/pet_add_background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 45),
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
                Padding(
                  padding: const EdgeInsets.only(top: 120, left: 60),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Añade una mascota",
                        style: GoogleFonts.prompt(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                              color: Color(0xFF386057),
                              letterSpacing: .5),
                        ),
                      ),
                      Container(
                        width: size.width * 0.6,
                        alignment: Alignment.center,
                        child: TextField(
                          maxLength: 20,
                          decoration: const InputDecoration(
                            labelText: "Nombre de la mascota",
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
                            _petName = value;
                          },
                        ),
                      ),
                      Container(
                        width: size.width * 0.6,
                        alignment: Alignment.center,
                        child: TextField(
                          maxLength: 80,
                          decoration: const InputDecoration(
                            labelText: "Raza",
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
                            _petBreed = value;
                          },
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 195, top: 15),
                          child: DropdownSearch<String>(
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Animal",
                                hintText: "Selecciona uno",
                              ),
                            ),
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                            ),
                            items: const ["Perro", "Gato", "Conejo", "Otro"],
                            onChanged: (value) {
                              setState(() {
                                _type = value!;
                              });
                            },
                            selectedItem: "Perro",
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.6,
                        alignment: Alignment.center,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLength: 5,
                          decoration: const InputDecoration(
                            labelText: "Peso",
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
                            _petWeight = double.parse(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: Text(
                                "Ponle una imágen a tu mascota",
                                style: GoogleFonts.prompt(
                                  textStyle: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF386057),
                                      letterSpacing: .5),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 85),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        pickImage(ImageSource.camera);
                                      },
                                      icon: Icon(Icons.camera_alt)),
                                  IconButton(
                                      onPressed: () {
                                        pickImage(ImageSource.gallery);
                                      },
                                      icon: Icon(Icons.photo)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 45),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          child: Container(
                              width: 180,
                              height: 90,
                              child: image != null
                                  ? Image.file(image!, fit: BoxFit.cover)
                                  : Image.asset("assets/logo.png",
                                      fit: BoxFit.cover)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: MaterialButton(
                          onPressed: () async {
                            String token = '';
                            if (generalProvider.token != '')
                              token = generalProvider.token;
                            else {
                              token = await AuthService.getToken(
                                  client.email!, client.password!);
                            }
                            Pet pet = await PetService.savePet(
                                _petName,
                                _petBreed,
                                _type,
                                _petWeight,
                                image!,
                                token,
                                client);
                            if (pet != -5) {
                              Alert(
                                context: context,
                                type: AlertType.success,
                                title: "Mascota añadida",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Continuar",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () =>
                                        Navigator.pushReplacementNamed(
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
                                    "No se ha podido añadir la mascota, inténtelo más tarde",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Continuar",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () =>
                                        Navigator.pushReplacementNamed(
                                            context, "pet_page"),
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
                            'Añadir',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          color: Color(0xFF386057),
                          height: 35,
                          minWidth: 280,
                        ),
                      )
                    ],
                  ),
                ),
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
