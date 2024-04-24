import 'package:alarmduino_upc/ui/components/animated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          alignment: Alignment.center,
          child: const AnimatedText(),
        ),
      ),
      toolbarHeight: 150,
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: SizedBox(
            width: 80,
            height: 80,
            child: SvgPicture.asset(
              'assets/svg/svg.svg',
            )),
      ),
      title: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        alignment: Alignment.center,
        child: const Text(
          'AlArmDuino \nUPC',
          textAlign: TextAlign.center,
        ),
      ),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.transparent, // Hacer el fondo transparente
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 83, 190, 79),
              Color.fromARGB(255, 42, 141, 38)
            ],
            // Colores del gradiente
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      elevation: 0,
    );
  }
}
