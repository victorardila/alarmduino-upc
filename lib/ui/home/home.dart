import 'package:alarmduino_upc/ui/components/custom_appbar.dart';
import 'package:alarmduino_upc/ui/components/custom_drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:alarmduino_upc/ui/views/alarm_list.dart';
import 'package:alarmduino_upc/ui/views/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //VARIABLE GLOBAL KEY
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  //LISTAS
  List<int> _selectedIndexList = [0, 1];
  //VARIABLES
  int _page = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> views = <Widget>[
      const AlarmList(),
      const AlarmSettings(),
    ];
    return Scaffold(
      //Estilos del panel superior de la aplicacion
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(150), // Altura deseada del appbar
        child: CustomAppBar(),
      ),
      endDrawer: const CustomDrawer(),
      body: Container(
        // La altura debe ajustarse al tamaño de la pantalla restante
        height: MediaQuery.of(context).size.height - 150,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: views[_page],
      ),
      //Estilos para el panel de navegacion inferior de la aplicacion
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _selectedIndexList[_page],
        height: 60.0,
        items: <Widget>[
          const Icon(Icons.alarm_add_sharp, size: 30, color: Colors.white),
          SvgPicture.asset(
            'assets/svg/settings-alarm.svg',
            color: Colors.white,
            height: 30,
            width: 30,
          ),
        ],
        color: const Color.fromARGB(255, 42, 141, 38),
        buttonBackgroundColor: const Color.fromARGB(255, 83, 190, 79),
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
