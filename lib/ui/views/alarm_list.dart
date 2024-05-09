import 'package:alarmduino_upc/domain/controllers/controller_alarm.dart';
import 'package:alarmduino_upc/ui/components/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AlarmList extends StatefulWidget {
  AlarmList({Key? key}) : super(key: key);

  @override
  State<AlarmList> createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  ControllerAlarm _controllerAlarm = Get.put(ControllerAlarm());
  List<Map<String, dynamic>> _alarms = [];
  late bool _isExpanded;

  void getAlarms() async {
    _controllerAlarm.getAlarms().then((value) {
      setState(() {
        _alarms = _controllerAlarm.datosAlarms;
      });
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
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                ),
                // Conteedor de la lista de alarmas
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
                            itemCount: _alarms.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(8.0),
                                padding: EdgeInsets.all(16.0),
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          Icon(Icons.alarm,
                                              color: Colors.black, size: 36.0),
                                          SizedBox(width: 16.0),
                                          Text(
                                              '${_alarms[index]['name']} - ${index + 1}',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.delete,
                                            color:
                                                Color.fromARGB(255, 255, 0, 0),
                                            size: 36.0))
                                  ],
                                ),
                              );
                            },
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
          }),
          _buildFabOption(Icons.alarm_add, 'Agregar', () {
            showDialog(
              context: context,
              builder: (context) {
                return CustomDialog(indexAlarmCurrent: _alarms.length + 1);
              },
            );
            // Handle option 2
          }),
          _buildFabOption(FontAwesomeIcons.trashCan, 'Borrar', () {
            // Handle option 3
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
