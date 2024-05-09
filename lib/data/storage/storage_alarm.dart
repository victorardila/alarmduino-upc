import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageAlarm {
  // Obtener el mensaje de los metodos globalmente
  static String msg = '';
  static List<Map<String, dynamic>> alarmsMap = [];

  static Future<dynamic> saveAlarm(Map<String, dynamic> alarm) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String datosString = jsonEncode(alarm);
      List<String> alarms = prefs.getStringList('alarmas') ?? [];
      alarms.add(datosString);
      prefs.setStringList('alarmas', alarms);
      msg = 'Guardado correctamente';
      return {msg, null};
    } catch (e) {
      msg = 'Error al guardar';
      return {msg, null};
    }
  }

  static Future<dynamic> getAlarms() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> alarms = prefs.getStringList('alarmas') ?? [];
      // Convertir cada dato de string a json
      alarms.forEach((element) {
        alarmsMap.add(jsonDecode(element));
      });
      msg = 'Datos obtenidos correctamente';
      return {msg, alarms};
    } catch (e) {
      msg = 'Error al obtener datos';
      return {msg, null};
    }
  }

  static Future<dynamic> filterAlarm(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> alarms = prefs.getStringList('alarmas') ?? [];
      List<String> alarm =
          alarms.where((element) => element.contains(id)).toList();
      // Convertir cada dato de string a json
      alarm.forEach((element) {
        alarmsMap.add(jsonDecode(element));
      });
      msg = 'Datos obtenidos correctamente';
      return {msg, alarm};
    } catch (e) {
      msg = 'Error al obtener datos';
      return {msg, null};
    }
  }

  static Future<dynamic> deleteAlarm(Map<String, dynamic> alarm) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> alarms = prefs.getStringList('alarmas') ?? [];
      alarms.removeWhere((element) => element.contains(alarm['id']));
      prefs.setStringList('alarms', alarms);
      msg = 'Eliminado correctamente';
      return {msg, alarm};
    } catch (e) {
      msg = 'Error al eliminar';
      return {msg, null};
    }
  }

  static Future<dynamic> updateAlarm(Map<String, dynamic> alarm) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> alarms = prefs.getStringList('alarmas') ?? [];
      alarms.removeWhere((element) => element.contains(alarm['id']));
      alarms.add(alarm.toString());
      prefs.setStringList('alarms', alarms);
      msg = 'Actualizado correctamente';
      return {msg, alarm};
    } catch (e) {
      msg = 'Error al actualizar';
      return {msg, null};
    }
  }
}
