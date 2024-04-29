import 'package:flutter/material.dart';

class ItemDay extends StatefulWidget {
  final int dia;
  final double alto;
  final double ancho;

  const ItemDay(
      {super.key, required this.dia, required this.alto, required this.ancho});

  @override
  _ItemDayState createState() => _ItemDayState();
}

class _ItemDayState extends State<ItemDay> {
  int dia = 0;
  double alto = 0;
  double ancho = 0;
  String texto = 'Lunes';
  List<String> dias = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    dia = widget.dia;
    alto = widget.alto;
    ancho = widget.ancho;
    texto = dias[dia];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            isSelected =
                !isSelected; // Cambia el estado de seleccionado/no seleccionado al tocar
          });
        },
        child: Container(
          height: alto,
          width: ancho,
          color: Colors.transparent,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300), // Duración de la animación
            margin: isSelected
                ? EdgeInsets.all(5)
                : EdgeInsets.all(0), // Añadir margen cuando está seleccionado
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isSelected
                    ? [
                        Color.fromARGB(255, 20, 180, 68),
                        Colors.lightGreenAccent
                      ]
                    : [
                        Color.fromARGB(255, 121, 219, 118),
                        Color.fromARGB(255, 74, 175, 70)
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                  color: isSelected ? Colors.green : Colors.transparent,
                  width: 2), // Añadir contorno verde cuando está seleccionado
            ),
            child: Text(
              texto,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Color.fromARGB(255, 255, 255, 254),
                fontSize: 20,
                fontFamily: 'Roboto-Regular',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}
