import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageAlarm {
  // Obtener el mensaje de los metodos globalmente
  static String msg = '';
  static List<Map<String, dynamic>> alarmsMap = [];

  static Future<dynamic> saveAlarm(Map<String, dynamic> alarm) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String datosString = jsonEncode(alarm); // Convertir el mapa a String
      List<String> alarms = prefs.getStringList('alarmas') ?? [];
      alarms.add(datosString);
      prefs.setStringList('alarmas', alarms);
      msg = 'Datos guardados correctamente';
      return {'message': msg, 'value': null};
    } catch (e) {
      msg = 'Error al guardar datos';
      return {'message': msg, 'value': null};
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
      return {'message': msg, 'value': alarms};
    } catch (e) {
      msg = 'Error al obtener datos';
      return {'message': msg, 'value': null};
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
      return {'message': msg, 'value': alarms};
    } catch (e) {
      msg = 'Error al obtener datos';
      return {'message': msg, 'value': null};
    }
  }

  static Future<dynamic> deleteAlarm(Map<String, dynamic> alarm) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> alarms = prefs.getStringList('alarmas') ?? [];
      alarms.removeWhere((element) => element.contains(alarm['id']));
      prefs.setStringList('alarmas', alarms);
      msg = 'Eliminado correctamente';
      return {'message': msg, 'value': alarms};
    } catch (e) {
      msg = 'Error al eliminar';
      return {'message': msg, 'value': null};
    }
  }

  static Future<dynamic> deleteAllAlarms() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('alarmas');
      msg = 'Eliminado correctamente';
      return {'message': msg, 'value': null};
    } catch (e) {
      msg = 'Error al eliminar';
      return {'message': msg, 'value': null};
    }
  }

  static Future<dynamic> updateAlarm(Map<String, dynamic> alarm) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String datosString = jsonEncode(alarm); // Convertir el mapa a String
      List<String> alarms = prefs.getStringList('alarmas') ?? [];
      alarms.removeWhere((element) => element.contains(alarm['id']));
      alarms.add(datosString);
      prefs.setStringList('alarmas', alarms);
      msg = 'Actualizado correctamente';
      return {'message': msg, 'value': alarms};
    } catch (e) {
      msg = 'Error al actualizar';
      return {'message': msg, 'value': null};
    }
  }
}
