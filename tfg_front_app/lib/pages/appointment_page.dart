import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tfg_front_app/models/appointment_model.dart';
import 'package:tfg_front_app/services/pet_service.dart';

import '../models/client_model.dart';
import '../models/pet_model.dart';
import '../providers/general_provider.dart';
import '../services/appointment_service.dart';
import '../user_preferences/user_preferences.dart';

/// My app class to display the date range picker
class AppointmentPage extends StatefulWidget {
  @override
  AppointmentPageState createState() => AppointmentPageState();
}

/// State for AppointmentPage
class AppointmentPageState extends State<AppointmentPage> {
  String _selectedDate = '';
  String _selectedTime = '';
  List<String> availableTimes = [
    "9:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00"
  ];

  // Appointment
  int _posTimeSelected = -1;
  String _phone = '';
  List<String> services = [];

  // Pet
  String _petName = '';
  String _petBreed = '';
  String _type = '';
  String _weight = '';
  int clientId = -1;

  void _onSelectionChanged(
      DateRangePickerSelectionChangedArgs args, String token) async {
    _selectedDate = sanitizeDateTime(args.value);
    availableTimes =
        await AppointmentService.getTimesByDate(_selectedDate, token);
    setState(() {});
  }

  final _advancedDrawerController = AdvancedDrawerController();
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petBreedController = TextEditingController();
  final TextEditingController _petWeightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GeneralProvider generalProvider = Provider.of<GeneralProvider>(context);
    Pet pet = generalProvider.selectedPetForAppointment;
    Client client = generalProvider.client;
    if (pet.id != -5) {
      _petName = pet.name!;
      _petNameController.text = _petName;
      _petBreed = pet.breed!;
      _petBreedController.text = _petBreed;
      _type = pet.type!;
      _weight = pet.weight!.toString();
      _petWeightController.text = _weight.toString();
      clientId = pet.clientId!;
    }
    final _prefs = PreferenciasUsuario();
    final size = MediaQuery.of(context).size;

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
            image: AssetImage("assets/appointment_background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 30),
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
                const Padding(
                  padding: EdgeInsets.only(left: 40, top: 15),
                  child: Text(
                    "Mascota",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 56, 97, 87),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 35, right: 35),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 15, bottom: 25),
                  child: Container(
                    width: size.width * 0.6,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _petNameController,
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 15, bottom: 25),
                  child: Container(
                    width: size.width * 0.6,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _petBreedController,
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
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 40, top: 15, bottom: 25, right: 118),
                    child: DropdownSearch<String>(
                      dropdownDecoratorProps: const DropDownDecoratorProps(
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
                      selectedItem: pet.id != -5 ? _type : "Perro",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 15, bottom: 25),
                  child: Container(
                    width: size.width * 0.6,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _petWeightController,
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
                        _weight = value.toString();
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 40, top: 15),
                  child: Text(
                    "Cita",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 56, 97, 87),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 35, right: 35),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 45, left: 45, bottom: 15, top: 15),
                      child: DropdownSearch<String>.multiSelection(
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Servicios",
                            hintText: "Selecciona uno",
                          ),
                        ),
                        items: const [
                          "Lavado",
                          "Secado",
                          "Arreglo a tijera",
                          "Arreglo a máquina",
                          "Stripping \n(Eliminar pelo muerto)",
                          "Deslanado \n(Eliminar exceso de pelo)"
                        ],
                        onChanged: (v) {
                          setState(() {
                            services = v;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 45, top: 20, bottom: 20),
                  child: Container(
                    width: size.width * 0.6,
                    alignment: Alignment.center,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 15,
                      decoration: const InputDecoration(
                        labelText: "Teléfono",
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
                        _phone = value.toString();
                      },
                    ),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 15),
                    child: Text(
                      "Selecciona un día",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromARGB(255, 56, 97, 87),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SfDateRangePicker(
                    onSelectionChanged: (value) =>
                        _onSelectionChanged(value, generalProvider.token),
                    selectionColor: Color.fromARGB(255, 56, 97, 87),
                    todayHighlightColor: Color.fromARGB(255, 56, 97, 87),
                    selectionMode: DateRangePickerSelectionMode.single,
                    initialDisplayDate: DateTime.now(),
                    selectableDayPredicate: (DateTime val) {
                      // Days before today
                      if (DateTime.now()
                          .subtract(Duration(days: 1))
                          .isAfter(val)) return false;

                      // Saturdays and Sundays
                      if (DateTime.saturday == val.weekday ||
                          DateTime.sunday == val.weekday) return false;

                      String sanitized = sanitizeDateTime(val);
                      return true;
                    },
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 15),
                    child: Text(
                      "Selecciona una hora",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromARGB(255, 56, 97, 87),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 500,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: ScrollController(),
                      itemCount: availableTimes.length,
                      itemBuilder: (_, pos) {
                        return MaterialButton(
                          elevation: 0,
                          onPressed: () {
                            _selectedTime = availableTimes[pos];

                            _posTimeSelected = pos;
                            setState(() {});
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Text(
                            availableTimes[pos],
                            style: TextStyle(
                              fontSize: 15,
                              color: _posTimeSelected != pos
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          color: _posTimeSelected != pos
                              ? Colors.transparent
                              : Color(0xFF386057),
                          minWidth: 25,
                        );
                      },
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 25),
                    child: MaterialButton(
                      onPressed: () async {
                        // pet insert
                        Pet pet = generalProvider.selectedPetForAppointment;
                        if (pet.id == -5) {
                          pet = await PetService.savePet(
                              _petName,
                              _petBreed,
                              _type,
                              double.parse(_weight),
                              null,
                              generalProvider.token,
                              Client(id: -5));
                        }
                        // appointment insert
                        Appointment appointment = Appointment();
                        appointment.date = _selectedDate;
                        appointment.hourCheck = _selectedTime;
                        appointment.pet = pet.id;
                        appointment.phone = _phone;
                        String finalServices = '|';
                        services.forEach(
                          (element) {
                            if (element == "Lavado") finalServices += "L|";
                            if (element == "Secado") finalServices += "S|";
                            if (element == "Arreglo a máquina")
                              finalServices += "AM|";
                            if (element == "Arreglo a tijera")
                              finalServices += "AT|";
                            if (element == "Stripping \n(Eliminar pelo muerto)")
                              finalServices += "St|";
                            if (element ==
                                "Deslanado \n(Eliminar exceso de pelo)")
                              finalServices += "D|";
                          },
                        );

                        appointment.services = finalServices;
                        int code = await AppointmentService.saveAppointment(
                            appointment);
                        generalProvider.setPet(Pet(id: -5));
                        if (code == 200) {
                          Alert(
                            context: context,
                            type: AlertType.success,
                            title: "Cita creada correctamente",
                            buttons: [
                              DialogButton(
                                child: const Text(
                                  "Continuar",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pushReplacementNamed(
                                    context, "intro_page"),
                                width: 120,
                              )
                            ],
                          ).show();
                        } else {
                          Alert(
                            context: context,
                            type: AlertType.error,
                            desc:
                                "No se ha podido crear la cita, por favor, inténtelo de nuevo más tarde.",
                            buttons: [
                              DialogButton(
                                child: const Text(
                                  "Continuar",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pushReplacementNamed(
                                    context, "intro_page"),
                                width: 120,
                              )
                            ],
                          ).show();
                        }
                      },
                      splashColor: Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Text(
                        'Continuar',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      color: Color(0xFF386057),
                      height: 35,
                      minWidth: 190,
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

  String sanitizeDateTime(DateTime dateTime) {
    String month = '';
    String day = '';

    if (dateTime.day.toString().length == 1) {
      day = '0${dateTime.day}';
    } else {
      day = dateTime.day.toString();
    }

    if (dateTime.month.toString().length == 1) {
      month = '0${dateTime.month}';
    } else {
      month = dateTime.month.toString();
    }

    return "${dateTime.year}-$month-$day";
  }

  Set<String> unselectableDates(List<DateTime> dates) =>
      dates.map(sanitizeDateTime).toSet();

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
