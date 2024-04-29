import 'package:alarmduino_upc/ui/components/hour_selection.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  CustomDialog({super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  String diaSeleccionado =
      'Lunes'; // Variable de estado para almacenar el valor seleccionado de la valoración
  var dias = <String>[
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sabado',
    'Domingo'
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: Colors.white,
      title: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Agregar alarma',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            Container(
                height: 30.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 83, 190, 79),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Cerrar el diálogo
                        },
                        child: Text(
                          '1',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {});
                    },
                    child: Container(
                      height: 60.0,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 83, 190,
                              79), // Puedes cambiar el color del borde aquí
                          width: 1.0, // Puedes ajustar el grosor del borde aquí
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.label, color: Colors.black),
                          SizedBox(width: 10.0),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                              decoration: InputDecoration(
                                hintText: 'Nombre de la alarma',
                                hintStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 5),
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              content: HourSelection(),
                              actions: <Widget>[
                                TextButton(
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 83, 190, 79),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Text('Cancelar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Cerrar el diálogo
                                  },
                                ),
                                TextButton(
                                  child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 83, 190, 79),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Text('Aceptar',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ))),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Cerrar el diálogo
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        // showTimePicker(
                        //   context: context,
                        //   initialTime: TimeOfDay.now(),
                        // );
                      });
                    },
                    child: Container(
                      height: 60.0,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 83, 190,
                              79), // Puedes cambiar el color del borde aquí
                          width: 1.0, // Puedes ajustar el grosor del borde aquí
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.alarm, color: Colors.black),
                          SizedBox(width: 10.0),
                          Text('00:00 AM',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0)),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        // Desplegar un
                      });
                    },
                    child: Container(
                      height: 60.0,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 83, 190,
                              79), // Puedes cambiar el color del borde aquí
                          width: 1.0, // Puedes ajustar el grosor del borde aquí
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                                Icons
                                    .calendar_month, // Puedes cambiar el icono aquí
                                color: Colors.black),
                          ),
                          Expanded(
                            child: DropdownButton(
                              hint: Text(
                                'Dia de la semana',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              dropdownColor: Colors.white,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              iconSize: 36,
                              isExpanded: true,
                              underline: SizedBox(),
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                              ),
                              value: diaSeleccionado,
                              alignment: Alignment
                                  .center, // Alinear el texto al centro
                              onChanged: (newValue) {
                                setState(() {
                                  diaSeleccionado = newValue
                                      .toString(); // Actualiza el valor seleccionado
                                });
                              },
                              items: dias.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar',
              style: TextStyle(
                color: Color.fromARGB(255, 83, 190, 79),
              )),
          onPressed: () {
            Navigator.of(context).pop(); // Cerrar el diálogo
          },
        ),
        TextButton(
          child: Text('Aceptar',
              style: TextStyle(color: Color.fromARGB(255, 83, 190, 79))),
          onPressed: () {
            Navigator.of(context).pop(); // Cerrar el diálogo
          },
        ),
      ],
    );
  }
}
