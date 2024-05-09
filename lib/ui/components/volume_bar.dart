import 'package:flutter/material.dart';

class VolumeBar extends StatefulWidget {
  final Color colorBar;
  final bool titleVisible;
  final bool margin;
  final double width;
  final double height;
  final double initialValue;
  final Function(double) onVolumeChanged;

  const VolumeBar({
    Key? key,
    this.colorBar = Colors.blue,
    this.titleVisible = true,
    this.margin = true,
    required this.width,
    required this.height,
    required this.initialValue,
    required this.onVolumeChanged,
  }) : super(key: key);

  @override
  _VolumeBarState createState() => _VolumeBarState();
}

class _VolumeBarState extends State<VolumeBar> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          padding:
              widget.titleVisible ? EdgeInsets.only(top: 15) : EdgeInsets.zero,
          margin: widget.margin
              ? EdgeInsets.only(top: 10, bottom: 10)
              : EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Container(
            color: Colors.transparent,
            margin: EdgeInsets.all(4),
            child: Stack(
              children: [
                Container(
                  height: widget.height,
                  width: widget.width * _currentValue,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 20, 180, 68),
                        Colors.lightGreenAccent,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Slider(
                      min: 0.0,
                      max: 1.0,
                      activeColor: widget.colorBar,
                      inactiveColor: widget.colorBar.withOpacity(0.3),
                      value: _currentValue,
                      onChanged: (newValue) {
                        setState(() {
                          _currentValue = newValue;
                        });
                        widget.onVolumeChanged(newValue);
                      },
                    ),
                  ),
                ),
                Positioned(
                  left: widget.width * _currentValue -
                      20, // Ajusta la posición del texto
                  top: widget.height / 2 - 20, // Ajusta la posición del texto
                  child: IgnorePointer(
                    child: Text(
                      '${(100 * _currentValue).toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: widget.titleVisible
              ? Center(
                  child: Text(
                    'Volume de timbre',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              : SizedBox(),
        ),
      ],
    );
  }
}
