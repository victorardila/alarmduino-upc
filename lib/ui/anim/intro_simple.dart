import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animate_do/animate_do.dart';

class IntroSimple extends StatefulWidget {
  const IntroSimple({super.key});

  @override
  State<IntroSimple> createState() => _IntroSimpleState();
}

class _IntroSimpleState extends State<IntroSimple> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context,
          '/principal'); // Navegar a la vista de inicio de sesión después de 5 segundos
      // Aquí puedes agregar tu código para navegar a la pantalla principal de tu aplicación
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors
          .white, // Puedes cambiar el color de fondo según tus necesidades
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BounceInDown(
              child: Image.asset(
                'assets/icon/icon.png', // Asegúrate de que la imagen se encuentre en la carpeta "assets" de tu proyecto
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            FadeIn(
              duration: Duration(milliseconds: 500),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'AlArmDuino UPC', // Puedes personalizar el nombre de tu aplicación aquí
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
