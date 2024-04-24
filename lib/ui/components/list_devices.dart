import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ListDevices extends StatefulWidget {
  final bluetooth;
  final devices;
  final isConnecting;
  final connection;
  const ListDevices({
    super.key,
    this.bluetooth,
    this.devices,
    this.isConnecting,
    this.connection,
  });

  @override
  State<ListDevices> createState() => _ListDevicesState();
}

class _ListDevicesState extends State<ListDevices> {
  List<BluetoothDevice> _devices = [];
  late FlutterBluetoothSerial _bluetooth;
  BluetoothConnection? _connection;
  BluetoothDevice? _deviceConnected;
  bool _isConnecting = false;

  @override
  void initState() {
    super.initState();
    _bluetooth = widget.bluetooth;
    _devices = widget.devices;
    _isConnecting = widget.isConnecting;
    _connection = widget.connection;
  }

  @override
  Widget build(BuildContext context) {
    return _isConnecting
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  ...[
                    for (final device in _devices)
                      ListTile(
                        title: Text(device.name ?? device.address),
                        trailing: TextButton(
                          child: const Text('conectar'),
                          onPressed: () async {
                            setState(() => _isConnecting = true);

                            _connection = await BluetoothConnection.toAddress(
                                device.address);
                            _deviceConnected = device;
                            _devices = [];
                            _isConnecting = false;
                            //_receiveData();
                            setState(() {});
                          },
                        ),
                      )
                  ]
                ],
              ),
            ),
          );
  }
}
