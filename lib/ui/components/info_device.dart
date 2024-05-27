import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class InfoDevice extends StatefulWidget {
  final bluetooth;
  final deviceConnected;
  final connection;
  final onDevicesVinculed;
  InfoDevice({
    super.key,
    this.bluetooth,
    this.deviceConnected,
    this.connection,
    this.onDevicesVinculed,
  });

  @override
  State<InfoDevice> createState() => _InfoDeviceState();
}

class _InfoDeviceState extends State<InfoDevice> {
  var _deviceConnected;
  bool _seeDevices = false;
  List<BluetoothDevice> _devices = [];
  late FlutterBluetoothSerial _bluetooth;
  BluetoothConnection? _connection;

  void _getDevices() async {
    var res = await _bluetooth.getBondedDevices();
    _seeDevices = !_seeDevices;
    if (_seeDevices) {
      setState(() {
        _devices = res;
        widget.onDevicesVinculed(_devices);
      });
    } else {
      setState(() {
        _devices = [];
        widget.onDevicesVinculed(_devices);
      });
    }
  }
  void getConnecteDevice(){
    setState(() {
      _deviceConnected = widget.deviceConnected;
    });
  }
  @override
  void initState() {
    super.initState();
    _getDevices();
    print("Hola");
    _bluetooth = widget.bluetooth;
    getConnecteDevice();
    _connection = widget.connection;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 24, 34, 24).withOpacity(0.7),
      child: ListTile(
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
                style:
                    TextStyle(color: Colors.white // Color para "Conectado a:"
                        ),
              ),
              TextSpan(
                text: '${_deviceConnected ?? "Ninguno"}',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height*0.025,
                  color: _deviceConnected != null
                      ? Color.fromARGB(255, 43, 184, 48)
                      : Color.fromARGB(255, 159, 28, 28), // Color para el nombre del dispositivo,
                ),
              ),
            ],
          ),
        ),
        trailing: _connection?.isConnected ?? false
            ? TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 230, 0, 0),
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
                child: Text("Desconectar"),
              )
            : TextButton(
                onPressed: _getDevices,
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 43, 184, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Radio de borde circular
                  ),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: _seeDevices
                    ? Text(
                        "Ocultar vinculados",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.032,
                            color: Colors.white,
                            fontFamily: 'Poppins'),
                      )
                    : Text(
                        "Ver vinculados",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.032,
                            color: Colors.white,
                            fontFamily: 'Poppins'),
                      ),
              ),
      ),
    );
  }
}
