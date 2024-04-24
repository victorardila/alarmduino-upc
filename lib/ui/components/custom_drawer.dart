import 'package:alarmduino_upc/ui/components/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class CustomDrawer extends StatefulWidget {
  final bluetooth;
  final bluetoothState;
  final devices;
  final deviceConnected;
  final isConnecting;
  final connection;
  const CustomDrawer({
    super.key,
    this.bluetooth,
    this.bluetoothState,
    this.devices,
    this.deviceConnected,
    this.isConnecting,
    this.connection,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  // Creamos variables para el estado del bluetooth
  late var bluetooth;
  bool _bluetoothState = false;
  bool _isConnecting = false;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _deviceConnected;
  @override
  void initState() {
    super.initState();
    // Obtenemos el estado del bluetooth
    bluetooth = FlutterBluetoothSerial.instance;
    _bluetoothState = widget.bluetoothState;
    _isConnecting = widget.isConnecting;
    _connection = widget.connection;
    _devices = widget.devices;
    _deviceConnected = widget.deviceConnected;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 83, 190, 79),
            ),
            child: CustonSwitch(
              bluetooth: bluetooth,
              bluetoothState: _bluetoothState,
            ),
          ),
          ListTile(
            title: const Text('Alarmas'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Configuración'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
