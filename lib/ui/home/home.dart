import 'package:alarmduino_upc/ui/components/anim_text.dart';
import 'package:alarmduino_upc/ui/views/alarm_list.dart';
import 'package:alarmduino_upc/ui/views/alarm_settings.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> _views = <Widget>[
      const AlarmList(),
      const AlarmSettings(),
    ];
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Container(
            color: const Color(0xFF47A644),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: Image.asset(
                          'assets/svg/LogoUPC.svg',
                          fit: BoxFit
                              .contain, // Opción de ajuste para el tamaño del SVG
                        ),
                      ),
                      //const SizedBox(width: 30,),
                      const Text(
                        "AlArmDuino \nUPC",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      //onst SizedBox(width: 70,),
                      IconButton(
                          onPressed: () {},
                          icon: const Image(
                            image: AssetImage('assets/img/preferences.png'),
                            width: 40,
                            height: 40,
                          )),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const AnimatedText(),
                  )
                  //const MyAnimatedText()
                  // const Text(
                  //       "<No Device Connection>",
                  //       style: TextStyle(
                  //         backgroundColor: Colors.amber,
                  //         color: Colors.white,
                  //         fontSize:15),
                  //         textAlign: TextAlign.center,
                  //     ),
                ]),
          )),
    );
  }
}
