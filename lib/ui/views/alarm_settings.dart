import 'package:alarmduino_upc/ui/components/hour_selection.dart';
import 'package:alarmduino_upc/ui/components/item_day.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlarmSettings extends StatefulWidget {
  const AlarmSettings({super.key});

  @override
  State<AlarmSettings> createState() => _AlarmSettingsState();
}

class _AlarmSettingsState extends State<AlarmSettings> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.235,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: const Color.fromARGB(255, 242, 226, 5),
              child: Column(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.031,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Days of the week",
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontFamily: 'Italianno-Regular',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            FontAwesomeIcons.solidCalendarDays,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 20,
                          )
                        ],
                      )),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(218, 216, 216, 1),
                        width: 2,
                      ),
                      color: const Color.fromRGBO(243, 242, 242, 1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    // Crear lista de scroll horizontal
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return ItemDay(
                          dia: index,
                          alto: MediaQuery.of(context).size.height * 0.123,
                          ancho: MediaQuery.of(context).size.width * 0.3,
                        );
                      },
                    ),
                    // child: GridView.count(
                    //   crossAxisCount: 3,
                    //   children: List.generate(7, (index) {
                    //     return ItemDay(
                    //       dia: index,
                    //       alto: MediaQuery.of(context).size.height * 0.123,
                    //       ancho: MediaQuery.of(context).size.width * 0.3,
                    //     );
                    //   }),
                    // ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.46,
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 242, 226, 5),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Set alarm",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontFamily: 'Italianno-Regular',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        FontAwesomeIcons.cog,
                        color: Color.fromARGB(255, 0, 0, 0),
                        size: 20,
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.43,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(218, 216, 216, 1),
                      width: 2,
                    ),
                    color: Color.fromRGBO(243, 242, 242, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: HourSelection(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
