import 'dart:convert';

import 'package:flutter/material.dart';

class CustomFilterDay extends StatefulWidget {
  final alarms;
  final onAlarmsFiltered;
  const CustomFilterDay({super.key, this.alarms, this.onAlarmsFiltered});

  @override
  State<CustomFilterDay> createState() => _CustomFilterDayState();
}

class _CustomFilterDayState extends State<CustomFilterDay> {
  List<String> filters = [
    "Todas",
    "Lunes",
    "Martes",
    "Miercoles",
    "Jueves",
    "Viernes",
    "Sabado",
    "Domingo"
  ];

  void seleccionarFilter(String filter) {
    if (filter == "Todas") {
      widget.onAlarmsFiltered(widget.alarms);
    } else {
      List<String> alarmsFiltered = [];
      for (var alarm in widget.alarms) {
        // Convertir alarm a un json
        Map<String, dynamic> alarmJson = jsonDecode(alarm);
        if (alarmJson['day'] == filter) {
          print(alarmJson['day']);
          alarmsFiltered.add(alarm);
        }
      }
      print(alarmsFiltered);
      widget.onAlarmsFiltered(alarmsFiltered);
    }
  }

  String selectedCategoryId = "Todas";

  List<Widget> buildFilters() {
    return filters.map((filter) {
      bool isSelected = selectedCategoryId == filter;
      return Container(
        padding: EdgeInsets.only(left: 15, bottom: 10),
        child: ElevatedButton(
          child: Text(
            filter,
            style: TextStyle(fontSize: 14),
          ),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
              isSelected ? Colors.white : Colors.black38,
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              isSelected ? Colors.green : Colors.white,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          onPressed: () {
            setState(() {
              selectedCategoryId = filter;
              seleccionarFilter(filter);
            });
          },
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: MediaQuery.of(context).size.height * 0.08,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: buildFilters(),
      ),
    );
  }
}
