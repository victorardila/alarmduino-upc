import 'package:alarmduino_upc/ui/components/text_picker.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class HourSelection extends StatefulWidget {
  final String timeInitial;
  final customFormat;
  final units;
  final onHourSelected;
  HourSelection(
      {super.key,
      required this.timeInitial,
      this.customFormat,
      this.units,
      this.onHourSelected});

  @override
  State<HourSelection> createState() => _HourSelectionState();
}

class _HourSelectionState extends State<HourSelection> {
  TextEditingController _timeController = TextEditingController();
  TextEditingController _hoursController = TextEditingController();
  TextEditingController _minutosController = TextEditingController();
  TextEditingController _formatoController = TextEditingController();

  var hour = 0;
  var minute = 0;
  var timeFormatIndex = 0;
  final timeFormats = ["PM", "AM"];

  void callbackValueHour(String hourSelected) {
    widget.onHourSelected(hourSelected);
  }

  String getSelectedTimeFormat(int timeFormatIndex) {
    if (timeFormatIndex == 0) {
      return "AM";
    } else if (timeFormatIndex == 1) {
      return "PM";
    } else {
      throw Exception("Invalid timeFormatIndex: $timeFormatIndex");
    }
  }

  void extractTime() {
    var time = widget.timeInitial.split(" ");
    var hourMinute = time[0].split(":");
    hour = int.parse(hourMinute[0]);
    minute = int.parse(hourMinute[1]);
    timeFormatIndex = timeFormats.indexOf(time[1]);
    _hoursController.text = hour.toString();
    _minutosController.text = minute.toString();
    widget.customFormat
        ? _formatoController.text = getSelectedTimeFormat(timeFormatIndex)
        : _formatoController.text = '';
    widget.customFormat
        ? _timeController.text =
            "${_hoursController.text.padLeft(2, '0')}:${_minutosController.text.padLeft(2, '0')} ${widget.customFormat ? time[1] : ''}"
        : _timeController.text =
            "${_hoursController.text.padLeft(2, '0')}:${_minutosController.text.padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
    extractTime();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 243, 243),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _timeController.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontFamily: "Roboto",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 243, 243),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.units
                    ? Text(
                        "Horas",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          fontFamily: "Roboto",
                        ),
                      )
                    : Container(),
                NumberPicker(
                  minValue: 0,
                  maxValue: 12,
                  value: int.parse(_hoursController.text),
                  zeroPad: true,
                  infiniteLoop: true,
                  itemWidth: 80,
                  itemHeight: 60,
                  onChanged: (value) {
                    setState(() {
                      _hoursController.text = value.toString();
                      _timeController.text =
                          "${_hoursController.text.padLeft(2, '0')}:${_minutosController.text.padLeft(2, '0')} ${widget.customFormat ? getSelectedTimeFormat(timeFormatIndex) : ''}";
                      callbackValueHour(_timeController.text);
                    });
                  },
                  textStyle: TextStyle(
                      color: Color.fromARGB(255, 36, 35, 35),
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                  selectedTextStyle:
                      TextStyle(color: Colors.black, fontSize: 30),
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                          color: Colors.black,
                        ),
                        bottom: BorderSide(color: Colors.black)),
                  ),
                ),
                NumberPicker(
                  minValue: 0,
                  maxValue: 59,
                  value: int.parse(_minutosController.text),
                  zeroPad: true,
                  infiniteLoop: true,
                  itemWidth: 80,
                  itemHeight: 60,
                  onChanged: (value) {
                    setState(() {
                      _minutosController.text = value.toString();
                      print(timeFormatIndex);
                      _timeController.text =
                          "${_hoursController.text.padLeft(2, '0')}:${_minutosController.text.padLeft(2, '0')} ${widget.customFormat ? getSelectedTimeFormat(timeFormatIndex) : ''}";
                      callbackValueHour(_timeController.text);
                    });
                  },
                  textStyle: TextStyle(
                      color: Color.fromARGB(255, 36, 35, 35),
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                  selectedTextStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        bottom:
                            BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
                  ),
                ),
                widget.units
                    ? Text(
                        "Minutos",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          fontFamily: "Roboto",
                        ),
                      )
                    : Container(),
                widget.customFormat
                    ? TextPicker(
                        items: timeFormats,
                        selectedItem: _formatoController.text,
                        itemWidth: MediaQuery.of(context).size.width * 0.15,
                        itemHeight: 60,
                        onChanged: (value) {
                          setState(() {
                            timeFormatIndex = timeFormats.indexOf(value);
                            _formatoController.text =
                                timeFormats[timeFormatIndex];
                            _timeController.text =
                                "${_hoursController.text.padLeft(2, '0')}:${_minutosController.text.padLeft(2, '0')} ${widget.customFormat ? getSelectedTimeFormat(timeFormatIndex) : ''}";
                            callbackValueHour(_timeController.text);
                          });
                        },
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 36, 35, 35),
                            fontSize: MediaQuery.of(context).size.width * 0.04),
                        selectedTextStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0))),
                        ),
                      )
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
