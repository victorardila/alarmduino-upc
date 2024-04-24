import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlarmList extends StatefulWidget {
  const AlarmList({Key? key}) : super(key: key);

  @override
  State<AlarmList> createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
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
                  child: Text('Lista de alarmas',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6.0,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Icon(Icons.alarm,
                                      color: Colors.black, size: 36.0),
                                  SizedBox(width: 16.0),
                                  Text('Alarm ${index + 1}',
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
                                    color: Colors.red, size: 36.0))
                          ],
                        ),
                      );
                    },
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
                  duration: const Duration(milliseconds: 300),
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
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFabOption(FontAwesomeIcons.bellConcierge, 'Test', () {
            // Handle option 1
          }),
          _buildFabOption(Icons.alarm_add, 'Agregar', () {
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
          tooltip: label,
          onPressed: onPressed,
          mini: false, // Cambiado a false para aumentar el tamaño
          backgroundColor: Color.fromARGB(255, 83, 190, 79),
          child: Icon(icon,
              color: Colors.white, size: 36.0), // Aumentado el tamaño del icono
          heroTag: null, // Evita la superposición de botones
        ),
        const SizedBox(height: 8.0),
        Text(label, style: TextStyle(color: Colors.black)),
      ],
    );
  }
}
