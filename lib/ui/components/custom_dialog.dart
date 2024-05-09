import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:alarmduino_upc/domain/controllers/controller_alarm.dart';
import 'package:alarmduino_upc/ui/components/hour_selection.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

class CustomDialog extends StatefulWidget {
  final indexAlarmCurrent;
  CustomDialog({super.key, this.indexAlarmCurrent});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  ControllerAlarm _controllerAlarm = Get.put(ControllerAlarm());
  TextEditingController _indexController = TextEditingController();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _horaController = TextEditingController();
  TextEditingController _diaController = TextEditingController();

  String time = '00:00 AM';
  List<String> alarma = [];
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

  void getHour(String hour) {
    this.time = hour;
    setState(() {
      _horaController.text = hour;
    });
  }

  void setAlarm() {
    alarma[0] = _nombreController.text;
    alarma[1] = _horaController.text;
    alarma[2] = _diaController.text;
  }

  @override
  void initState() {
    super.initState();
    _indexController.text = '1';
    _nombreController.text = 'Alarma 1';
    _horaController.text = '00:00 AM';
    _diaController.text = 'Lunes';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: Colors.white,
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Agregar timbre',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
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
                          widget.indexAlarmCurrent == null
                              ? '1'
                              : widget.indexAlarmCurrent.toString(),
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
                          color: Colors.grey
                              .shade400, // Puedes cambiar el color del borde aquí
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
                              content: HourSelection(
                                  timeInitial: time,
                                  units: false,
                                  onHourSelected: getHour,
                                  customFormat: true),
                              actions: <Widget>[
                                // Ver los botones en el centro
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        child: Container(
                                            padding: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 83, 190, 79),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Text('Seleccionar',
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
                                  ),
                                )
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
                          color: Colors.grey
                              .shade400, // Puedes cambiar el color del borde aquí
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
                          Text(_horaController.text,
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
                          color: Colors.grey
                              .shade400, // Puedes cambiar el color del borde aquí
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
                fontFamily: 'Roboto',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              )),
          onPressed: () {
            Navigator.of(context).pop(); // Cerrar el diálogo
          },
        ),
        TextButton(
          child: Text('Aceptar',
              style: TextStyle(
                color: Color.fromARGB(255, 83, 190, 79),
                fontFamily: 'Roboto',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              )),
          onPressed: () {
            try {
              _controllerAlarm.saveAlarm({
                'id': Uuid().v4(),
                'name': _nombreController.text,
                'hour': _horaController.text,
                'day': _diaController.text,
              }).then((value) {
                if (_controllerAlarm.mensajeAlarm == "Guardado correctamente") {
                  Navigator.of(context).pop();
                  AwesomeSnackbarContent(
                    title: 'Alarma guardada correctamente',
                    titleFontSize: 15.0,
                    message: 'La alarma se ha guardado correctamente',
                    contentType: ContentType.success,
                  );
                } else {
                  AwesomeSnackbarContent(
                    title: 'Error al guardar la alarma',
                    titleFontSize: 15.0,
                    message: 'Ha ocurrido un error al guardar la alarma',
                    contentType: ContentType.failure,
                  );
                }
              });
            } catch (e) {
              Navigator.of(context).pop();
              AwesomeSnackbarContent(
                title: 'Error al guardar la alarma',
                titleFontSize: 15.0,
                message: 'Ha ocurrido un error interno',
                contentType: ContentType.failure,
              );
            }
          },
        ),
      ],
    );
  }
}
