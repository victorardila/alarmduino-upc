import 'package:alarmduino_upc/ui/components/custom_switch.dart';
import 'package:alarmduino_upc/ui/components/info_device.dart';
import 'package:alarmduino_upc/ui/components/list_devices.dart';
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
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 121, 219, 118),
                Color.fromARGB(255, 74, 175, 70)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: Center(
              child: CustonSwitch(
                bluetooth: bluetooth,
                bluetoothState: _bluetoothState,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                InfoDevice(
                  deviceConnected: _deviceConnected,
                  connection: _connection,
                  bluetooth: bluetooth,
                ),
                ListDevices(
                  bluetooth: bluetooth,
                  devices: _devices,
                  isConnecting: _isConnecting,
                  connection: _connection,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
