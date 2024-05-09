import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDeviceList extends StatefulWidget {
  final bluetooth;
  final bluetoothState;
  final isConnecting;

  const BluetoothDeviceList({
    Key? key,
    required this.bluetooth,
    required this.bluetoothState,
    required this.isConnecting,
  }) : super(key: key);

  @override
  _BluetoothDeviceListState createState() => _BluetoothDeviceListState();
}

class _BluetoothDeviceListState extends State<BluetoothDeviceList> {
  // List of available Bluetooth devices
  List<BluetoothDevice> _devicesList = [];
  // Stream subscription for scanning
  StreamSubscription<BluetoothDiscoveryResult>? _discoverySubscription;

  @override
  void initState() {
    super.initState();

    // Check Bluetooth state initially
    _checkBluetoothState();
  }

  // Check Bluetooth state and handle permission request if needed
  void _checkBluetoothState() async {
    final state = await FlutterBluetoothSerial.instance.state;

    if (state == BluetoothState.STATE_OFF) {
      // Request permission if Bluetooth is off
      print('Requesting permission to enable Bluetooth...');
      await FlutterBluetoothSerial.instance.requestEnable();
    }

    // Start scanning when Bluetooth is on
    if (state == BluetoothState.STATE_ON) {
      print('Bluetooth is on, starting to scan for available devices...');
      _startScanning();
    }

    // Listen for Bluetooth state changes
    widget.bluetoothState.listen((state) {
      if (state == BluetoothState.STATE_ON) {
        _startScanning();
      } else {
        _stopScanning();
        setState(() {
          _devicesList.clear();
        });
      }
    });
  }

  // Start scanning for Bluetooth devices
  void _startScanning() {
    print('Scanning for available Bluetooth devices...');
    _discoverySubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((result) {
      setState(() {
        _devicesList.add(result.device);
        print(_devicesList.length);
      });
    });
  }

  // Stop scanning for Bluetooth devices
  void _stopScanning() {
    _discoverySubscription?.cancel();
  }

  @override
  void dispose() {
    _stopScanning();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        itemCount: _devicesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_devicesList[index].name ?? 'Unknown Device',
                style: TextStyle(color: Colors.black)),
            subtitle: Text(_devicesList[index].address),
            onTap: () => // Handle tapping on a device (optional)
                widget.bluetooth.connect(_devicesList[index]).then((value) {
              if (value) {
                _stopScanning();
              }
            }),
          );
        },
      ),
    );
  }
}
