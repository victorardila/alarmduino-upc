import 'package:alarmduino_upc/ui/components/custom_appbar.dart';
import 'package:alarmduino_upc/ui/components/custom_drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:alarmduino_upc/ui/views/alarm_list.dart';
import 'package:alarmduino_upc/ui/views/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  Home({super.key});

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
  final _bluetooth = FlutterBluetoothSerial.instance;
  bool _bluetoothState = false;
  bool _isConnecting = false;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _deviceConnected;

  void _requestPermission() async {
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
  }

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _bluetooth.state.then((state) {
      setState(() => _bluetoothState = state.isEnabled);
    });
    _bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BluetoothState.STATE_OFF:
          setState(() => _bluetoothState = false);
          break;
        case BluetoothState.STATE_ON:
          setState(() => _bluetoothState = true);
          break;
        // case BluetoothState.STATE_TURNING_OFF:
        //   break;
        // case BluetoothState.STATE_TURNING_ON:
        //   break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> views = <Widget>[
      AlarmList(),
      AlarmSettings(),
    ];
    return Scaffold(
      //Estilos del panel superior de la aplicacion
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150), // Altura deseada del appbar
        child: CustomAppBar(),
      ),
      endDrawer: CustomDrawer(
        bluetooth: _bluetooth,
        bluetoothState: _bluetoothState,
        devices: _devices,
        deviceConnected: _deviceConnected,
        isConnecting: _isConnecting,
        connection: _connection,
      ),
      body: Container(
        // La altura debe ajustarse al tamaño de la pantalla restante
        height: MediaQuery.of(context).size.height - 150,
        decoration: BoxDecoration(
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
          Icon(Icons.alarm_add_sharp, size: 30, color: Colors.white),
          SvgPicture.asset(
            'assets/svg/settings-alarm.svg',
            colorFilter: ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
            height: 30,
            width: 30,
          ),
        ],
        color: Color.fromARGB(255, 42, 141, 38),
        buttonBackgroundColor: Color.fromARGB(255, 83, 190, 79),
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
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
