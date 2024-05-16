import 'dart:convert';

import 'package:alarmduino_upc/domain/controllers/controller_alarm.dart';
import 'package:alarmduino_upc/ui/components/gradient_button.dart';
import 'package:alarmduino_upc/ui/components/intervals_time.dart';
import 'package:alarmduino_upc/ui/components/item_day.dart';
import 'package:alarmduino_upc/ui/components/type_sound.dart';
import 'package:alarmduino_upc/ui/components/volume_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AlarmSettings extends StatefulWidget {
  AlarmSettings({super.key});

  @override
  State<AlarmSettings> createState() => _AlarmSettingsState();
}

class _AlarmSettingsState extends State<AlarmSettings> {
  ControllerAlarm _controllerAlarm = Get.put(ControllerAlarm());
  TextEditingController _volumeController = TextEditingController();
  TextEditingController _soundController = TextEditingController();
  TextEditingController _intervalsController = TextEditingController();
  List<Map<String, dynamic>> _alarms = [];
  List<int> selectedDays = [];
  List<Map<String, dynamic>> configuredDays = [];
  List<String> days = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];

  void setNewAlarm() {
    if (selectedDays.length > 0) {
      _alarms.forEach((alarm) {
        if (selectedDays.contains(days.indexOf(alarm['day']))) {
          Map<String, dynamic> newAlarm = {
            ...alarm,
            'day': alarm['day'],
            'volume': _volumeController.text,
            'sound': _soundController.text,
            'intervals': _intervalsController.text,
          };
          _controllerAlarm.updateAlarm(newAlarm).then((value) {
            if (_controllerAlarm.mensajeAlarm.contains('correctamente')) {
              Navigator.of(context).pop();
              final snackBar = SnackBar(
                /// need to set following properties for best effect of awesome_snackbar_content
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Alarma modificada correctamente',
                  titleFontSize: MediaQuery.of(context).size.width * 0.04,
                  message:
                      'Se ha modificado la alarma correctamente', // set your message here

                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                  contentType: ContentType.warning,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              final snackBar = SnackBar(
                /// need to set following properties for best effect of awesome_snackbar_content
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Error al guardar la alarma',
                  titleFontSize: MediaQuery.of(context).size.width * 0.04,
                  message: 'Ha ocurrido un error al guardar la alarma',

                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                  contentType: ContentType.success,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          });
        }
      });
    }
  }

  void getAlarms() async {
    _controllerAlarm.getAlarms().then((value) {
      setState(() {
        List<String> alarms = _controllerAlarm.datosAlarms;
        alarms.forEach((alarm) {
          _alarms.add(jsonDecode(alarm));
        });
        print(_alarms);
      });
    });
  }

  void verifyConfiguredDays(int dayIndex) {
    _alarms.forEach((alarms) {
      if (alarms['day'] == days[dayIndex]) {
        _volumeController.text = alarms['volume'] ?? '0.0';
        _soundController.text = alarms['sound'] ?? '0';
        _intervalsController.text = '${alarms['intervals']} AM' ?? '00:00 AM';
      }
    });
  }

  void handleDaySelection(int dayIndex) {
    setState(() {
      if (selectedDays.contains(dayIndex)) {
        selectedDays.remove(dayIndex);
      } else {
        selectedDays.add(dayIndex);
      }
      verifyConfiguredDays(dayIndex);
    });
  }

  @override
  void initState() {
    super.initState();
    _volumeController.text = '0.0';
    _soundController.text = '0';
    _intervalsController.text = '00:00 AM';
    getAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 121, 219, 118),
                  Color.fromARGB(255, 74, 175, 70)
                ],
                // Colores del gradiente
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Configuración de timbre",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 254),
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontFamily: 'Italianno-Regular',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.235,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: Color.fromARGB(255, 242, 226, 5),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Días de la semana",
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              fontFamily: 'Italianno-Regular',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            FontAwesomeIcons.solidCalendarDays,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 20,
                          )
                        ],
                      )),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.185,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(218, 216, 216, 1),
                        width: 2,
                      ),
                      color: Color.fromRGBO(243, 242, 242, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    // Crear lista de scroll horizontal
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return ItemDay(
                          dia: index,
                          alto: MediaQuery.of(context).size.height * 0.123,
                          ancho: MediaQuery.of(context).size.width * 0.3,
                          onDaySelected:
                              handleDaySelection, // Paso de la función de selección
                        );
                      },
                    ),
                    // child: GridView.count(
                    //   crossAxisCount: 3,
                    //   children: List.generate(7, (index) {
                    //     return ItemDay(
                    //       dia: index,
                    //       alto: MediaQuery.of(context).size.height * 0.123,
                    //       ancho: MediaQuery.of(context).size.width * 0.3,
                    //     );
                    //   }),
                    // ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 242, 226, 5),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Configurar timbre",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontFamily: 'Italianno-Regular',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          FontAwesomeIcons.gear,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.336,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(218, 216, 216, 1),
                            width: 2,
                          ),
                          color: Color.fromRGBO(243, 242, 242, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            selectedDays.length > 0
                                ? AnimatedContainer(
                                    duration: Duration(
                                        milliseconds:
                                            500), // Duración de la animación (0.5 segundos)
                                    curve: Curves
                                        .easeInOut, // Curva de la animación
                                    height: selectedDays.length > 0
                                        ? MediaQuery.of(context).size.height *
                                            0.05
                                        : 0, // Altura del contenedor basada en si hay días seleccionados
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 121, 219, 118),
                                          Color.fromARGB(255, 74, 175, 70)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 2),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        selectedDays
                                            .map((dayIndex) => days[dayIndex])
                                            .join(", "),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                          fontFamily: 'Italianno-Regular',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.symmetric(vertical: 2),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "No hay días seleccionados",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        fontFamily: 'Italianno-Regular',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Container(
                                  child: Column(
                                    children: [
                                      VolumeBar(
                                        colorBar:
                                            Color.fromARGB(255, 74, 175, 70),
                                        titleVisible: true,
                                        margin: true,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        initialValue: double.parse(
                                            _volumeController.text),
                                        onVolumeChanged: (value) {
                                          print(value);
                                        },
                                      ),
                                      TypeSound(
                                        titleVisible: true,
                                        margin: true,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.16,
                                        initialValue:
                                            double.parse(_soundController.text),
                                      ),
                                      IntervalsTime(
                                        colorBar:
                                            Color.fromARGB(255, 74, 175, 70),
                                        titleVisible: true,
                                        units: true,
                                        margin: true,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.475,
                                        initialValue: _intervalsController.text,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: GradientButton(
                                          text: "Guardar alarma",
                                          onPressed: () {
                                            setNewAlarm();
                                          },
                                          gradientColors: [
                                            Color.fromARGB(255, 121, 219, 118),
                                            Color.fromARGB(255, 74, 175, 70)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
