import 'package:alarmduino_upc/data/storage/storage_alarm.dart';
import 'package:get/get.dart';

class ControllerAlarm extends GetxController {
  final _response = Rxn();
  final _Datos = Rxn();
  final _mensaje = "".obs;

  Future<void> saveAlarm(Map<String, dynamic> alarm) async {
    _response.value = await StorageAlarm.saveAlarm(alarm);
    await controlAlarm(_response.value);
    return _response.value;
  }

  Future<void> getAlarms() async {
    _response.value = await StorageAlarm.getAlarms();
    await controlAlarm(_response.value);
    return _response.value;
  }

  Future<void> filterAlarm(String id) async {
    _response.value = await StorageAlarm.filterAlarm(id);
    await controlAlarm(_response.value);
    return _response.value;
  }

  Future<void> deleteAlarm(Map<String, dynamic> alarm) async {
    _response.value = await StorageAlarm.deleteAlarm(alarm);
    await controlAlarm(_response.value);
    return _response.value;
  }

  Future<void> deleteAllAlarms() async {
    _response.value = await StorageAlarm.deleteAllAlarms();
    await controlAlarm(_response.value);
    return _response.value;
  }

  Future<void> updateAlarm(Map<String, dynamic> alarm) async {
    _response.value = await StorageAlarm.updateAlarm(alarm);
    await controlAlarm(_response.value);
    return _response.value;
  }

  Future<void> controlAlarm(dynamic respuesta) async {
    if (respuesta == null) {
      _mensaje.value = "Ha ocurrido un error";
      print(_mensaje.value);
    } else {
      _mensaje.value = respuesta['message'];
      _Datos.value = respuesta['value'];
    }
  }

  List<String> get datosAlarms => _Datos.value ?? [];
  dynamic get estadoAlarm => _response.value;
  String get mensajeAlarm => _mensaje.value;
}
