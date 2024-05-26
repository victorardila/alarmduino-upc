import 'package:alarmduino_upc/ui/components/bluetooth_device.dart';
import 'package:alarmduino_upc/ui/components/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class CustomConnection extends StatefulWidget {
  final bluetooth;
  final bluetoothState;
  final onBluetoothStateChange;
  final isConnecting;
  final connection;
  final devices;
  final deviceConnected;
  CustomConnection(
      {super.key,
      this.bluetooth,
      this.bluetoothState,
      this.onBluetoothStateChange,
      this.isConnecting,
      this.connection,
      this.devices,
      this.deviceConnected});

  @override
  State<CustomConnection> createState() => _CustomConnectionState();
}

class _CustomConnectionState extends State<CustomConnection> {
  List<Map<String, dynamic>> labelStrings = [];
  // Creamos variables para el estado del bluetooth
  late var bluetooth;
  bool state = false;
  bool _isConnecting = false;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _deviceConnected;
  late Stream<BluetoothState> _bluetoothState;

  // Método para obtener el estado actual del Bluetooth
  Future<void> _getBluetoothState() async {
    bluetooth = FlutterBluetoothSerial.instance;
    bool isEnabled = await bluetooth.isEnabled;
    setState(() {
      state = isEnabled;
    });
  }

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
    print('Devices: $_devices');
    _deviceConnected = widget.deviceConnected;
    //Inicializamos labelStrings
    labelStrings = [
      {
        'label': 'Bluetooth',
        'color': Colors.black,
        'icon': Icons.bluetooth,
        'img': 'assets/img/bluetooth.png',
        'colorIcon': Colors.blue,
      },
      {
        'label': 'WiFi',
        'color': Colors.black,
        'icon': Icons.wifi,
        'img': 'assets/img/wifi.png',
        'colorIcon': Colors.blue,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Expanded(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return InkWell(
              child: Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        labelStrings[index]['img'],
                        width: 30,
                        height: 30,
                      ),
                      Text(
                        labelStrings[index]['label'],
                        style: TextStyle(
                          color: labelStrings[index]['color'],
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                        child: CustonSwitch(
                          icon: false,
                          label: false,
                          logoMode: false,
                          bluetooth: bluetooth,
                          bluetoothState: state,
                          onBluetoothStateChange: (bool value) {
                            setState(() {
                              state = value;
                              _bluetoothState = bluetooth.onStateChanged();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.42,
                      width: MediaQuery.of(context).size.width,
                      child: // detectamos si el bluetooth esta activado
                          state
                              ? SingleChildScrollView(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        //Mostramos la lista de dispositivos vinculados
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 10,
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'Dispositivos vinculados',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.03,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                ],
                                              ),
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    6,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: _devices.length,
                                                  itemBuilder:
                                                      (context, index) {
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
                                        ),
                                        //Mostramos la lista de dispositivos disponibles
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: BluetoothDeviceList(
                                            bluetooth: bluetooth,
                                            bluetoothState: _bluetoothState,
                                            state: state,
                                            isConnecting: _isConnecting,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Bluetooth desactivado',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
