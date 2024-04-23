import 'package:flutter/material.dart';

class ItemDay extends StatefulWidget {
  final int dia;
  final double alto;
  final double ancho;
  const ItemDay(
      {super.key, required this.dia, required this.alto, required this.ancho});

  @override
  State<ItemDay> createState() => _ItemDayState();
}

class _ItemDayState extends State<ItemDay> {
  // lista de dias
  int dia = 0;
  double alto = 0;
  double ancho = 0;
  String text = 'Lunes';
  List<String> dias = [
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sabado',
    'Domingo'
  ];

  @override
  void initState() {
    super.initState();
    dia = widget.dia;
    alto = widget.alto;
    ancho = widget.ancho;
    text = dias[dia];
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Container(
        height: alto,
        width: ancho,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
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
        child: Text(
          text,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 254),
            fontSize: 20,
            fontFamily: 'Roboto-Regular',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
