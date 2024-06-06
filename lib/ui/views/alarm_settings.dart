import 'dart:convert';

import 'package:alarmduino_upc/domain/controllers/controller_alarm.dart';
import 'package:alarmduino_upc/ui/components/gradient_button.dart';
import 'package:alarmduino_upc/ui/components/hour_selection.dart';
import 'package:alarmduino_upc/ui/components/intervals_time.dart';
import 'package:alarmduino_upc/ui/components/item_day.dart';
import 'package:alarmduino_upc/ui/components/type_sound.dart';
// import 'package:alarmduino_upc/ui/components/volume_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AlarmSettings extends StatefulWidget {
  final connection;
  final deviceConnected;
  AlarmSettings({super.key, this.connection, this.deviceConnected});

  @override
  State<AlarmSettings> createState() => _AlarmSettingsState();
}

class _AlarmSettingsState extends State<AlarmSettings> {
  ControllerAlarm _controllerAlarm = Get.put(ControllerAlarm());
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _volumeController = TextEditingController();
  TextEditingController _soundController = TextEditingController();
  TextEditingController _horaController = TextEditingController();
  List<int> selectedDays = [];
  List<String> messages = [];
  List<String> _alarms = [];
  List<Map<String, dynamic>> configuredDays = [];
  String time = '00:00 AM';
  List<String> days = [
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sabado',
    'Domingo'
  ];

  // formatear hora al formato militar
  String formedtime() {
    String time = _horaController.text;
    print(time);
    String hour = time.split(":")[0];
    String minutes = time.split(":")[1].split(" ")[0];
    String ampm = time.split(":")[1].split(" ")[1];
    ampm == "AM" ? ampm = "PM" : ampm = "AM";
    if (ampm == "AM") {
      int hourInt = int.parse(hour);
      if (hourInt < 12) {
        hourInt += 12;
        hour = hourInt.toString();
      }
    }
    var horaFormateada = "$hour:$minutes";
    return horaFormateada;
  }

  // los dias seleccionados se guardan en un array de strings tomara solo las tres primeras letras de cada dia
  String formedDay(String day) {
    String dayFormated = day.substring(0, 3);
    return dayFormated;
  }

  String padToLength(String message, int length) {
    if (message.length >= length) {
      return message;
    } else {
      print(length - message.length);
      int spaces = length - message.length;
      for (int i = 0; i < spaces + 1; i++) {
        message += "-";
      }
      return message;
    }
  }

  void sendBluetoothMessage(String day) {
    // Recorrer los días seleccionados
    String dayFormted = formedDay(day);
    // Enviar alarma a la placa
    String command = "SAVE";
    String message = " " + _nombreController.text.toUpperCase();
    // toma
    message += "/" + dayFormted;
    message += "/" + formedtime();
    message += "/" + _soundController.text;
    message += "/";
    // Asegurar que el mensaje tenga 26 caracteres
    message = padToLength(message, 26);
    message = command += message;
    print("Mensaje a enviar: $message");
    sendbluetooth(message);
  }

  sendbluetooth(String message) {
    if (widget.connection != null) {
      widget.connection!.output.add(utf8.encode(message + "\n"));
      setState(() {
        messages.add("Sent: $message");
        print("mensaje enviado");
      });
    } else {
      print("Conexion invalida");
    }
  }

  void getAlarms() async {
    _controllerAlarm.getAlarms().then((value) {
      setState(() {
        _alarms = _controllerAlarm.datosAlarms;
      });
    });
  }

  // Guarda la alarma sin repetir la hora por dia
  void saveAlarm() {
    if (selectedDays.length > 0) {
      for (var i = 0; i < selectedDays.length; i++) {
        // convertir _alarms a una lista de jsons
        List<Map<String, dynamic>> alarmsJson = [];
        for (var i = 0; i < _alarms.length; i++) {
          alarmsJson.add(jsonDecode(_alarms[i]));
        }
        print(alarmsJson);
        // Verificar si la alarma ya existe con la misma hora
        bool exists = alarmsJson.any((element) =>
            element['hour'] == _horaController.text &&
            element['day'] == days[selectedDays[i]]);
        print(exists);
        if (!exists) {
          _controllerAlarm.saveAlarm({
            'id': Uuid().v4(),
            'name': _nombreController.text,
            'sound': _soundController.text,
            'hour': _horaController.text,
            'day': days[selectedDays[i]],
          }).then((value) {});
          if (_controllerAlarm.mensajeAlarm.contains('correctamente')) {
            Navigator.of(context).pop();
            final snackBar = SnackBar(
              /// need to set following properties for best effect of awesome_snackbar_content
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Alarma guardada correctamente',
                titleFontSize: MediaQuery.of(context).size.width * 0.04,
                message:
                    'Se ha guardado la alarma correctamente', // set your message here

                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                contentType: ContentType.success,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            sendBluetoothMessage(days[selectedDays[i]]);
            // me envia a la pantalla de alarmas
            Navigator.of(context).pushNamed('/principal');
          }
        } else {
          Navigator.of(context).pop();
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Error al guardar el timbre',
              titleFontSize: MediaQuery.of(context).size.width * 0.04,
              message:
                  'Ya se guardo un timbre para ese horario', // set your message here

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.success,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } else {
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error al guardar la alarma',
          titleFontSize: MediaQuery.of(context).size.width * 0.04,
          message:
              'No ha seleccionado ningun dia para el timbre', // set your message here

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void getSound(String sound) {
    this._soundController.text = sound;
  }

  void handleDaySelection(int dayIndex) {
    setState(() {
      if (selectedDays.contains(dayIndex)) {
        selectedDays.remove(dayIndex);
      } else {
        selectedDays.add(dayIndex);
      }
    });
  }

  void getHour(String hour) {
    this.time = hour;
    setState(() {
      _horaController.text = hour;
    });
  }

  @override
  void initState() {
    super.initState();
    _volumeController.text = '0.0';
    _horaController.text = '00:00 AM';
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
                          daySelected: selectedDays.contains(index),
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
                                      InkWell(
                                        onTap: () {
                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 60.0,
                                          margin: EdgeInsets.only(
                                              top: 10.0, bottom: 10.0),
                                          // ancho de la pantalla
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey
                                                  .shade400, // Puedes cambiar el color del borde aquí
                                              width:
                                                  1.0, // Puedes ajustar el grosor del borde aquí
                                            ),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                blurRadius: 6.0,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.label,
                                                  color: Colors.black),
                                              SizedBox(width: 10.0),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: TextField(
                                                  controller: _nombreController,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.0),
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Nombre de la alarma',
                                                    hintStyle: TextStyle(
                                                        color: Colors.black),
                                                    border: InputBorder.none,
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {});
                                                  },
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        12),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  '${_nombreController.text.length}/12',
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.6)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),

                                      // VolumeBar(
                                      //   colorBar:
                                      //       Color.fromARGB(255, 74, 175, 70),
                                      //   titleVisible: true,
                                      //   margin: true,
                                      //   width:
                                      //       MediaQuery.of(context).size.width *
                                      //           0.9,
                                      //   height:
                                      //       MediaQuery.of(context).size.height *
                                      //           0.08,
                                      //   initialValue: double.parse(
                                      //       _volumeController.text),
                                      //   onVolumeChanged: (value) {
                                      //     print(value);
                                      //   },
                                      // ),
                                      TypeSound(
                                          titleVisible: true,
                                          margin: true,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.16,
                                          initialValue: 0,
                                          onSoundSelected: getSound),
                                      HourSelection(
                                          timeInitial: time,
                                          units: false,
                                          onHourSelected: getHour,
                                          customFormat: true),
                                      // IntervalsTime(
                                      //   colorBar:
                                      //       Color.fromARGB(255, 74, 175, 70),
                                      //   titleVisible: true,
                                      //   units: true,
                                      //   margin: true,
                                      //   width:
                                      //       MediaQuery.of(context).size.width *
                                      //           0.9,
                                      //   height:
                                      //       MediaQuery.of(context).size.height *
                                      //           0.475,
                                      //   initialValue: _intervalsController.text,
                                      // ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: GradientButton(
                                          text: "Guardar timbre",
                                          onPressed: () {
                                            saveAlarm();
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
