import 'package:alarmduino_upc/ui/components/text_picker.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class HourSelection extends StatefulWidget {
  HourSelection({super.key});

  @override
  State<HourSelection> createState() => _HourSelectionState();
}

class _HourSelectionState extends State<HourSelection> {
  var hour = 0;
  var minute = 0;
  var timeFormatIndex = 0;
  final timeFormats = ["PM", "AM"];

  String getSelectedTimeFormat(int timeFormatIndex) {
    if (timeFormatIndex == 0) {
      return "AM";
    } else if (timeFormatIndex == 1) {
      return "PM";
    } else {
      throw Exception("Invalid timeFormatIndex: $timeFormatIndex");
    }
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
                  "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, "0")} ${getSelectedTimeFormat(timeFormatIndex)}",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberPicker(
                  minValue: 0,
                  maxValue: 12,
                  value: hour,
                  zeroPad: true,
                  infiniteLoop: true,
                  itemWidth: 80,
                  itemHeight: 60,
                  onChanged: (value) {
                    setState(() {
                      hour = value;
                    });
                  },
                  textStyle: TextStyle(
                      color: Color.fromARGB(255, 36, 35, 35), fontSize: 20),
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
                  value: minute,
                  zeroPad: true,
                  infiniteLoop: true,
                  itemWidth: 80,
                  itemHeight: 60,
                  onChanged: (value) {
                    setState(() {
                      minute = value;
                    });
                  },
                  textStyle: TextStyle(
                      color: Color.fromARGB(255, 36, 35, 35), fontSize: 20),
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
                TextPicker(
                  items: timeFormats,
                  selectedItem: timeFormats[timeFormatIndex],
                  itemWidth: 80,
                  itemHeight: 60,
                  onChanged: (value) {
                    setState(() {
                      timeFormatIndex = timeFormats.indexOf(value);
                    });
                  },
                  textStyle: TextStyle(
                      color: Color.fromARGB(255, 36, 35, 35), fontSize: 20),
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
