import 'package:flutter/material.dart';

class AlarmSettings extends StatefulWidget {
  const AlarmSettings({super.key});

  @override
  State<AlarmSettings> createState() => _AlarmSettingsState();
}

class _AlarmSettingsState extends State<AlarmSettings> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 30,
              width: MediaQuery.of(context).size.width,
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Alarm Settings",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 254),
                      fontSize: 20,
                      fontFamily: 'Italianno-Regular',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(),
            Container()
          ],
        ),
      ),
    );
  }
}
