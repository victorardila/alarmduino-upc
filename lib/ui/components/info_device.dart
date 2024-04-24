import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class InfoDevice extends StatefulWidget {
  final bluetooth;
  final deviceConnected;
  final connection;
  const InfoDevice({
    super.key,
    this.bluetooth,
    this.deviceConnected,
    this.connection,
  });

  @override
  State<InfoDevice> createState() => _InfoDeviceState();
}

class _InfoDeviceState extends State<InfoDevice> {
  late var _deviceConnected;
  List<BluetoothDevice> _devices = [];
  late FlutterBluetoothSerial _bluetooth;
  BluetoothConnection? _connection;

  void _getDevices() async {
    var res = await _bluetooth.getBondedDevices();
    setState(() => _devices = res);
  }

  @override
  void initState() {
    super.initState();
    _bluetooth = widget.bluetooth;
    _deviceConnected = widget.deviceConnected;
    _connection = widget.connection;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.black12,
      title: Text("Conectado a: ${_deviceConnected?.name ?? "ninguno"}"),
      trailing: _connection?.isConnected ?? false
          ? TextButton(
              onPressed: () async {
                await _connection?.finish();
                setState(() => _deviceConnected = null);
              },
              child: const Text("Desconectar"),
            )
          : TextButton(
              onPressed: _getDevices,
              child: const Text("Ver dispositivos"),
            ),
    );
  }
}
