import 'package:alarmduino_upc/ui/components/hour_selection.dart';
import 'package:flutter/material.dart';

class IntervalsTime extends StatefulWidget {
  final Color colorBar;
  final bool titleVisible;
  final bool margin;
  final double width;
  final double height;
  final String initialValue;
  final bool units;
  IntervalsTime(
      {super.key,
      this.colorBar = Colors.blue,
      this.titleVisible = true,
      this.margin = true,
      required this.width,
      required this.height,
      required this.initialValue,
      required this.units});

  @override
  State<IntervalsTime> createState() => _IntervalsTimeState();
}

class _IntervalsTimeState extends State<IntervalsTime> {
  String time = '00:00 AM';

  void getHour(String hour) {
    this.time = hour;
  }

  @override
  void initState() {
    super.initState();
    // El initialValue viene así: '00:00 AM' o '00:00 PM' quiero solo la hora
    getHour(widget.initialValue.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.titleVisible
          ? EdgeInsets.symmetric(vertical: 10)
          : EdgeInsets.zero,
      margin: widget.margin
          ? EdgeInsets.only(top: 10, bottom: 10)
          : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.titleVisible
              ? Text(
                  'Intervalos de tocada',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Container(),
          Container(
              width: widget.width,
              child: HourSelection(
                  timeInitial: time,
                  units: widget.units,
                  onHourSelected: getHour,
                  customFormat: false)),
        ],
      ),
    );
  }
}
