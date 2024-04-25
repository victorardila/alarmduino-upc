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
      tileColor: Color.fromARGB(255, 24, 34, 24).withOpacity(0.7),
      title: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
          ),
          children: [
            TextSpan(
              text: 'Conectado a: ',
              style: TextStyle(color: Colors.white // Color para "Conectado a:"
                  ),
            ),
            TextSpan(
              text: '${_deviceConnected?.name ?? "Ninguno"}',
              style: TextStyle(
                fontSize: 16,
                color: _deviceConnected?.name != null
                    ? const Color.fromARGB(255, 43, 184, 48)
                    : Color.fromARGB(255, 230, 0,
                        0), // Color para el nombre del dispositivo,
              ),
            ),
          ],
        ),
      ),
      trailing: _connection?.isConnected ?? false
          ? TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 230, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Radio de borde circular
                ),
                textStyle: TextStyle(
                    fontSize: 18, color: Colors.white, fontFamily: 'Poppins'),
              ),
              onPressed: () async {
                await _connection?.finish();
                setState(() => _deviceConnected = null);
              },
              child: const Text("Desconectar"),
            )
          : TextButton(
              onPressed: _getDevices,
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 43, 184, 48),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Radio de borde circular
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text(
                "Ver dispositivos",
                style: TextStyle(
                    fontSize: 18, color: Colors.white, fontFamily: 'Poppins'),
              ),
            ),
    );
  }
}
