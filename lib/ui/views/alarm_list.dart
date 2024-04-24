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
