import 'package:alarmduino_upc/ui/components/custom_switch.dart';
import 'package:alarmduino_upc/ui/components/info_device.dart';
import 'package:alarmduino_upc/ui/components/bluetooth_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';

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
  bool state = false;
  bool _isConnecting = false;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _deviceConnected;
  late Stream<BluetoothState> _bluetoothState;

  @override
  void initState() {
    super.initState();
    _bluetoothState = FlutterBluetoothSerial.instance.onStateChanged();
    _getBluetoothState();
    // Obtenemos el estado del bluetooth
    bluetooth = FlutterBluetoothSerial.instance;
    state = widget.bluetoothState;
    _isConnecting = widget.isConnecting;
    _connection = widget.connection;
    _devices = widget.devices;
    _deviceConnected = widget.deviceConnected;
  }

  // Método para obtener el estado actual del Bluetooth
  Future<void> _getBluetoothState() async {
    bluetooth = FlutterBluetoothSerial.instance;
    bool isEnabled = await bluetooth.isEnabled;
    setState(() {
      state = isEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 74, 175, 70),
      child: Container(
        margin: EdgeInsets.only(top: 40),
        color: Colors.white.withOpacity(0.9),
        child: ListView(
          padding: EdgeInsets.zero,
          physics:
              NeverScrollableScrollPhysics(), // Deshabilita el scroll automático
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
                  bluetoothState: state,
                  onBluetoothStateChange: (bool value) {
                    setState(() {
                      state = value;
                      _bluetoothState = bluetooth.onStateChanged();
                    });
                  },
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
                    onDevicesVinculed: (List<BluetoothDevice> devices) {
                      setState(() {
                        _devices = devices;
                      });
                    },
                  ),
                  // detectamos si el bluetooth esta activado
                  Container(
                      child: state
                          ? Column(
                              children: [
                                //Mostramos la lista de dispositivos vinculados
                                _devices.length > 0
                                    ? Container(
                                        margin: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                        ),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          //bordes solo a la izquierda y derecha
                                          border: Border.all(
                                            color: Color.fromRGBO(
                                                218, 216, 216, 1),
                                            width: 0.5,
                                          ),
                                          color:
                                              Color.fromRGBO(243, 242, 242, 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Dispositivos vinculados',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5,
                                              child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount: _devices.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    leading: Icon(
                                                      Icons.bluetooth,
                                                      color: Colors.blue,
                                                    ),
                                                    trailing: Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Colors.black,
                                                    ),
                                                    title: Text(
                                                      _devices[index].name ??
                                                          'Desconocido',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      _devices[index].address,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      bluetooth
                                                          .cancelDiscovery();
                                                      Navigator.pop(context,
                                                          _devices[index]);
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                //Mostramos la lista de dispositivos disponibles
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 5,
                                  ),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromRGBO(218, 216, 216, 1),
                                      width: 2,
                                    ),
                                    color: Color.fromRGBO(243, 242, 242, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: BluetoothDeviceList(
                                    bluetooth: bluetooth,
                                    bluetoothState: _bluetoothState,
                                    state: state,
                                    isConnecting: _isConnecting,
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromRGBO(218, 216, 216, 1),
                                  width: 2,
                                ),
                                color: Color.fromRGBO(243, 242, 242, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Text(
                                'Bluetooth desactivado',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            )),

                  // ListDevices(
                  //   bluetooth: bluetooth,
                  //   devices: _devices,
                  //   isConnecting: _isConnecting,
                  //   connection: _connection,
                  // ),
                ],
              ),
            ),
            EndDrawerButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                padding: MaterialStateProperty.all(EdgeInsets.all(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
