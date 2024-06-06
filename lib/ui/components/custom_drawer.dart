import 'package:alarmduino_upc/ui/components/custom_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';

class CustomDrawer extends StatefulWidget {
  final bluetooth;
  final bluetoothState;
  final devices;
  final deviceConected;
  final isConnecting;
  final connection;
  final onBluetoothConnection;
  final onDeviceConected;
  final onState;
  const CustomDrawer(
      {super.key,
      this.bluetooth,
      this.bluetoothState,
      this.devices,
      this.deviceConected,
      this.isConnecting,
      this.connection,
      this.onBluetoothConnection,
      this.onDeviceConected,
      this.onState});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  BluetoothConnection? _connection;
  bool _state = false;
  var _deviceConnected;

  void getConnectedDevice(String device) {
    setState(() {
      this._deviceConnected = device;
    });
    print("Dispositivo conectado en el drawer: ${_deviceConnected}");
    _callBackonDeviceConected(device);
  }

  void _callBackonDeviceConected(String device) async {
    widget.onDeviceConected(device);
  }

  void getConnection(BluetoothConnection connection) {
    setState(() {
      this._connection = connection;
    });
    _callBackConnectedDevice(_connection!);
  }

  void _callBackConnectedDevice(BluetoothConnection connection) async {
    widget.onBluetoothConnection(connection);
  }

  void getState(bool state) {
    setState(() {
      this._state = state;
    });
    _callBackState(_state);
  }

  void _callBackState(bool state) {
    widget.onState(state);
  }

  @override
  void initState() {
    super.initState();
    _deviceConnected = widget.deviceConected != "" ? widget.deviceConected : "";
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 74, 175, 70),
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      minRadius: 40,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/icon/icon.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Conexion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                // child: CustonSwitch(
                //   bluetooth: bluetooth,
                //   bluetoothState: state,
                //   onBluetoothStateChange: (bool value) {
                //     setState(() {
                //       state = value;
                //       _bluetoothState = bluetooth.onStateChanged();
                //     });
                //   },
                // ),
              ),
            ),
            CustomConnection(
                bluetooth: widget.bluetooth,
                bluetoothState: widget.bluetoothState,
                devices: widget.devices,
                deviceConnected: _deviceConnected,
                isConnecting: widget.isConnecting,
                connection: widget.connection,
                onBluetoothConnection: getConnection,
                onDeviceConected: getConnectedDevice,
                onState: getState),
            // Container(
            //   height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   child: Column(
            //     children: [
            //       InfoDevice(
            //         deviceConnected: _deviceConnected,
            //         connection: _connection,
            //         bluetooth: bluetooth,
            //         onDevicesVinculed: (List<BluetoothDevice> devices) {
            //           setState(() {
            //             _devices = devices;
            //           });
            //         },
            //       ),
            //       // detectamos si el bluetooth esta activado
            //       Container(
            //           child: state
            //               ? Column(
            //                   children: [
            //                     //Mostramos la lista de dispositivos vinculados
            //                     _devices.length > 0
            //                         ? Container(
            //                             margin: EdgeInsets.only(
            //                               left: 10,
            //                               right: 10,
            //                               top: 10,
            //                             ),
            //                             padding: EdgeInsets.all(10),
            //                             decoration: BoxDecoration(
            //                               //bordes solo a la izquierda y derecha
            //                               border: Border.all(
            //                                 color: Color.fromRGBO(
            //                                     218, 216, 216, 1),
            //                                 width: 0.5,
            //                               ),
            //                               color:
            //                                   Color.fromRGBO(243, 242, 242, 1),
            //                               borderRadius: BorderRadius.all(
            //                                   Radius.circular(10)),
            //                             ),
            //                             child: Column(
            //                               children: [
            //                                 Row(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment.start,
            //                                   children: [
            //                                     Text('Dispositivos vinculados',
            //                                         style: TextStyle(
            //                                             fontSize: MediaQuery.of(
            //                                                         context)
            //                                                     .size
            //                                                     .width *
            //                                                 0.04,
            //                                             fontWeight:
            //                                                 FontWeight.bold,
            //                                             color: Colors.black)),
            //                                   ],
            //                                 ),
            //                                 Container(
            //                                   height: MediaQuery.of(context)
            //                                           .size
            //                                           .height /
            //                                       5,
            //                                   child: ListView.builder(
            //                                     scrollDirection: Axis.vertical,
            //                                     itemCount: _devices.length,
            //                                     itemBuilder: (context, index) {
            //                                       return ListTile(
            //                                         leading: Icon(
            //                                           Icons.bluetooth,
            //                                           color: Colors.blue,
            //                                         ),
            //                                         trailing: Icon(
            //                                           Icons.arrow_forward_ios,
            //                                           color: Colors.black,
            //                                         ),
            //                                         title: Text(
            //                                           _devices[index].name ??
            //                                               'Desconocido',
            //                                           style: TextStyle(
            //                                             color: Colors.black,
            //                                             fontSize: 14,
            //                                           ),
            //                                         ),
            //                                         subtitle: Text(
            //                                           _devices[index].address,
            //                                           style: TextStyle(
            //                                             color: Colors.black,
            //                                             fontSize: 14,
            //                                           ),
            //                                         ),
            //                                         onTap: () {
            //                                           bluetooth
            //                                               .cancelDiscovery();
            //                                           Navigator.pop(context,
            //                                               _devices[index]);
            //                                         },
            //                                       );
            //                                     },
            //                                   ),
            //                                 ),
            //                               ],
            //                             ),
            //                           )
            //                         : Container(),
            //                     //Mostramos la lista de dispositivos disponibles
            //                     Container(
            //                       margin: EdgeInsets.only(
            //                         left: 10,
            //                         right: 10,
            //                         top: 5,
            //                       ),
            //                       padding: EdgeInsets.all(10),
            //                       decoration: BoxDecoration(
            //                         border: Border.all(
            //                           color: Color.fromRGBO(218, 216, 216, 1),
            //                           width: 2,
            //                         ),
            //                         color: Color.fromRGBO(243, 242, 242, 1),
            //                         borderRadius:
            //                             BorderRadius.all(Radius.circular(10)),
            //                       ),
            //                       child: BluetoothDeviceList(
            //                         bluetooth: bluetooth,
            //                         bluetoothState: _bluetoothState,
            //                         state: state,
            //                         isConnecting: _isConnecting,
            //                       ),
            //                     ),
            //                   ],
            //                 )
            //               : Container(
            //                   margin: EdgeInsets.all(10),
            //                   padding: EdgeInsets.all(10),
            //                   decoration: BoxDecoration(
            //                     border: Border.all(
            //                       color: Color.fromRGBO(218, 216, 216, 1),
            //                       width: 2,
            //                     ),
            //                     color: Color.fromRGBO(243, 242, 242, 1),
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(10)),
            //                   ),
            //                   child: Text(
            //                     'Bluetooth desactivado',
            //                     style: TextStyle(
            //                       color: Colors.black,
            //                       fontSize: 16,
            //                     ),
            //                   ),
            //                 )),
            //       // ListDevices(
            //       //   bluetooth: bluetooth,
            //       //   devices: _devices,
            //       //   isConnecting: _isConnecting,
            //       //   connection: _connection,
            //       // ),
            //     ],
            //   ),
            // ),
            // EndDrawerButton(
            //   style: ButtonStyle(
            //     backgroundColor: MaterialStateProperty.all(Colors.white),
            //     padding: MaterialStateProperty.all(EdgeInsets.all(10)),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
