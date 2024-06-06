import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

class ControllerBluetooth extends GetxController {
  final _conection = Rxn();
  final _listDevice = Rxn();
  final _deviceConnedted = Rxn();
  final _state = Rxn();
  final FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  final _mensaje = "".obs;

  @override
  void onInit() {
    super.onInit();
    _bluetooth.onStateChanged().listen((event) {
      _state.value = event;
    });
  }

  // Obtener el estado del bluetooth del dispositivo para saber si esta activado o desactivado
  void getBluetoothState() {
    _bluetooth.state.then((value) {
      _state.value = value;
    });
  }

  // Obtener los dispositivos vinculados al dispositivo
  void getDevices() {
    _bluetooth.getBondedDevices().then((value) {
      _listDevice.value = value;
    });
  }

  // Conectar a un dispositivo
  void connectDevice(BluetoothDevice device) {
    _bluetooth
        .connect(device)
        .then((value) => _conection.value = conection.isConnected)
        .catchError((onError) {
      _mensaje.value = onError.toString();
    });
    _deviceConnedted.value = device;
  }

  // Obtener datos del dispositivo conectado
  void getDeviceData() {
    _conection.value.input.listen((event) {
      _mensaje.value = event.toString();
    });
  }

  // Desconectar el dispositivo
  void disconnectDevice() {
    _conection.value.disconnect();
    _deviceConnedted.value = null;
  }

  // Obtener la lista de dispositivos
  void getDeviceList() {
    _bluetooth.startDiscovery().listen((event) {
      _listDevice.value = event;
    });
  }

  // Cambiar el estado de la conexión
  void setConnection(value) {
    _conection.value = value;
  }

  // Cambiar la lista de dispositivos
  void setListDevice(value) {
    _listDevice.value = value;
  }

  // Cambiar el dispositivo conectado
  void setDeviceConnected(value) {
    _deviceConnedted.value = value;
  }

  // Cambiar el estado del bluetooth
  void setState(value) {
    _state.value = value;
  }

  // Cambiar el mensaje
  void setMensaje(value) {
    _mensaje.value = value;
  }

  FlutterBluetoothSerial get bluetooth => _bluetooth;
  BluetoothConnection get conection => _conection.value;
  BluetoothDevice get deviceConnedted => _deviceConnedted.value;
  List<BluetoothDevice> get listDevice => _listDevice.value;
  BluetoothState get state => _state.value;
  String get mensaje => _mensaje.value;
}
