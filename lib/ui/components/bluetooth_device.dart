import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothDeviceList extends StatefulWidget {
  final FlutterBluetoothSerial bluetooth;
  final Stream<BluetoothState> bluetoothState;
  final dynamic state;
  final bool isConnecting;

  const BluetoothDeviceList({
    Key? key,
    required this.bluetooth,
    required this.bluetoothState,
    this.state,
    required this.isConnecting,
  }) : super(key: key);

  @override
  _BluetoothDeviceListState createState() => _BluetoothDeviceListState();
}

class _BluetoothDeviceListState extends State<BluetoothDeviceList> {
  List<BluetoothDevice> _devices = [];
  late StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  bool _isDiscovering = false;
  bool _isMounted = false;

  Future<void> _requestBluetoothPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.location,
    ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (allGranted) {
      _startDiscovery();
    } else {
      print('Permission to connect to Bluetooth devices denied');
      // You can show a snackbar or dialog to inform the user
    }
  }

  Future<void> _startDiscovery() async {
    setState(() {
      _isDiscovering = true;
      _devices.clear();
    });

    _streamSubscription = widget.bluetooth.startDiscovery().listen((r) {
      if (_isMounted) {
        setState(() {
          _devices.add(r.device);
          print('Found device: ${r.device.name}');
        });
      }
    });

    // Detener la búsqueda después de 5 segundos
    Future.delayed(Duration(seconds: 5)).then((_) {
      if (_isMounted) {
        widget.bluetooth.cancelDiscovery();
        setState(() {
          _isDiscovering = false;
        });
        print('Discovery stopped');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isMounted = true;

    widget.bluetoothState.listen((state) {
      if (_isMounted) {
        if (state == BluetoothState.STATE_ON) {
          _startDiscovery();
        } else {
          _requestBluetoothPermissions();
        }
      }
    });

    // Solicitar permisos al iniciar
    _requestBluetoothPermissions();
  }

  @override
  void dispose() {
    _isMounted = false;
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dispositivos disponibles',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.blue),
                onPressed: () {
                  _startDiscovery();
                },
              ),
            ],
          ),
          _isDiscovering
              ? Center(child: CircularProgressIndicator())
              : _devices.isEmpty
                  ? Center(
                      child: Text('No devices found',
                          style: TextStyle(fontSize: 16, color: Colors.black)))
                  : Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: _devices.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.devices, color: Colors.blue),
                            trailing: Icon(
                              Icons.connect_without_contact,
                              color: Colors.black,
                            ),
                            title: Text(_devices[index].name ?? 'Unknown',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                            subtitle: Text(_devices[index].address,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            onTap: () async {
                              widget.bluetooth.cancelDiscovery();
                              Navigator.pop(context, _devices[index]);
                            },
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
