import 'package:alarmduino_upc/ui/components/animated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatefulWidget {
  final connection;
  final deviceConnected;
  CustomAppBar({super.key, this.connection, this.deviceConnected});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          alignment: Alignment.center,
          child: AnimatedText(
              connection: widget.connection,
              deviceConnected: widget.deviceConnected),
        ),
      ),
      toolbarHeight: 150,
      titleSpacing: 0,
      leading: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: SizedBox(
            width: 80,
            height: 80,
            child: SvgPicture.asset(
              'assets/svg/svg.svg',
              colorFilter: ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            )),
      ),
      title: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        alignment: Alignment.center,
        child: Text(
          'AlArmDuino \nUPC',
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.08,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.transparent, // Hacer el fondo transparente
      flexibleSpace: Container(
        decoration: BoxDecoration(
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
