import 'dart:convert';
import 'package:alarmduino_upc/domain/controllers/controller_alarm.dart';
import 'package:alarmduino_upc/ui/components/custom_dialog.dart';
import 'package:alarmduino_upc/ui/components/custom_filterday.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AlarmList extends StatefulWidget {
  final connection;
  final deviceConnected;
  final onPageSelected;
  AlarmList(
      {super.key, this.connection, this.deviceConnected, this.onPageSelected});

  @override
  State<AlarmList> createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  ControllerAlarm _controllerAlarm = Get.put(ControllerAlarm());
  List<String> _alarms = [];
  List<String> _alarmsAux = [];
  List<String> messages = [];
  late bool _isExpanded;

  void getAlarms() async {
    _controllerAlarm.getAlarms().then((value) {
      setState(() {
        _alarms = _controllerAlarm.datosAlarms;
        _alarmsAux = _controllerAlarm.datosAlarms;
      });
    });
  }

  void deleteAlarm(String id) async {
    _controllerAlarm.deleteAlarm({'id': id}).then((value) {
      if (_controllerAlarm.mensajeAlarm.contains('correctamente')) {
        getAlarms();
      }
    });
  }

  void deleteAllAlarms() async {
    _controllerAlarm.deleteAllAlarms().then((value) {
      getAlarms();
    });
  }

  // Seleccionar vista de agregar alarma
  void setPage(int pageSelected) {
    print("Pagina seleccionada: $pageSelected");
    widget.onPageSelected(pageSelected);
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

  void getAlarmsFiltered(List<String> alarmsFiltered) {
    setState(() {
      _alarmsAux = alarmsFiltered;
      print("Alarms filtered: $_alarmsAux");
    });
  }

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
    getAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          //Agregar contenido a la vista
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            // Ver lista de alarmas
            child: Column(
              children: [
                Container(
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 243, 243, 243),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Lista de timbres',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                ),
                // Conteedor de la lista de alarmas
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        CustomFilterDay(
                            alarms: _alarms,
                            onAlarmsFiltered: getAlarmsFiltered),
                        Expanded(
                          child: Container(
                            child: _alarms.isEmpty
                                ? Center(
                                    child: Text('No hay timbres',
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  )
                                : ListView.builder(
                                    itemCount: _alarmsAux.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          // Llama a CustomDialog con los datos de la alarma seleccionada
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return CustomDialog(
                                                  indexAlarmCurrent: index + 1,
                                                  alarmCurrent: jsonDecode(
                                                      _alarmsAux[index]));
                                            },
                                          ).then((value) {
                                            // Llama a getAlarms() después de completar la acción en el CustomDialog
                                            getAlarms();
                                          });
                                        },
                                        child: Container(
                                            margin: EdgeInsets.all(8.0),
                                            padding: EdgeInsets.all(16.0),
                                            decoration: BoxDecoration(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.alarm,
                                                          color: Colors.black,
                                                          size: 36.0),
                                                      SizedBox(width: 16.0),
                                                      Expanded(
                                                        child: RichText(
                                                          maxLines: 3,
                                                          textAlign:
                                                              TextAlign.start,
                                                          text: TextSpan(
                                                            text:
                                                                'Timbre ${index + 1} Hora:${jsonDecode(_alarmsAux[index])['hour']}\n',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                  text: "Titulo: " +
                                                                      jsonDecode(
                                                                              _alarmsAux[index])[
                                                                          'name'] +
                                                                      "\n", // Hora
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                                  children: [
                                                                    TextSpan(
                                                                      text: "Días: " +
                                                                          jsonDecode(
                                                                              _alarmsAux[index])['day'],
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            15.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ],
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    String alarmString =
                                                        _alarms[index];
                                                    Map<String, dynamic>
                                                        alarmMap =
                                                        jsonDecode(alarmString);
                                                    deleteAlarm(alarmMap['id']);
                                                  },
                                                  icon: Icon(Icons.delete,
                                                      color: Color.fromARGB(
                                                          255, 255, 0, 0),
                                                      size: 36.0),
                                                ),
                                              ],
                                            )),
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: _isExpanded ? 200 : 0,
                  color: Colors.green,
                  child: _isExpanded ? _buildExpandedFabMenu() : null,
                ),
              ),
            ),
          ),
          Positioned(
            // Posicionar abajo a la derecha
            bottom: 16.0,
            right: 16.0, // Añadido para posicionar a la derecha
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              backgroundColor: Color.fromARGB(255, 83, 190, 79),
              child: Icon(_isExpanded ? Icons.close : Icons.add,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedFabMenu() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFabOption(FontAwesomeIcons.bellConcierge, 'Test', () {
            // Handle option 1
            sendbluetooth("TEST");
          }),
          _buildFabOption(Icons.alarm_add, 'Agregar', () {
            // Necesito que me lleve a la vista settings
            setPage(1);
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return CustomDialog(indexAlarmCurrent: _alarms.length + 1);
            //   },
            // ).then((value) {
            //   // Llama a getAlarms() después de completar la acción en el CustomDialog
            //   getAlarms();
            //   _isExpanded = false;
            // });
          }),
          _buildFabOption(FontAwesomeIcons.trashCan, 'Borrar', () {
            sendbluetooth("CLEAR");
            deleteAllAlarms();
            _isExpanded = false;
          }),
        ],
      ),
    );
  }

  Widget _buildFabOption(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          // Efecto toque
          tooltip: label,
          onPressed: onPressed,
          mini: false, // Cambiado a false para aumentar el tamaño
          backgroundColor: Color.fromARGB(255, 83, 190, 79),
          child: Icon(icon,
              color: Colors.white, size: 36.0), // Aumentado el tamaño del icono
          heroTag: null, // Evita la superposición de botones
        ),
        SizedBox(height: 8.0),
        Text(label,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ],
    );
  }
}
