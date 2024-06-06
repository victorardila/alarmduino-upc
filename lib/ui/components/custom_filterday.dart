import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomFilterDay extends StatefulWidget {
  const CustomFilterDay({super.key});

  @override
  State<CustomFilterDay> createState() => _CustomFilterDayState();
}

class _CustomFilterDayState extends State<CustomFilterDay> {
  List<String> filters = [
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado",
    "Domingo"
  ];
  void seleccionarFilter(filter) {}

  String selectedCategoryId = "0"; // ID de la categoría seleccionada
  List<Widget> buildFilters() {
    return filters.map((filter) {
      bool isSelected = selectedCategoryId == filter;
      return Container(
        padding: EdgeInsets.only(left: 15, bottom: 10),
        child: ElevatedButton(
          child: Row(
            children: [
              Text(
                filter,
                style: TextStyle(fontSize: 14),
              ),
            ],
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
