import 'package:flutter/material.dart';

class TypeSound extends StatefulWidget {
  final bool titleVisible;
  final bool margin;
  final double width;
  final double height;
  final double initialValue;
  final onSoundSelected;

  TypeSound({
    Key? key,
    this.titleVisible = true,
    this.margin = true,
    required this.width,
    required this.height,
    required this.initialValue,
    this.onSoundSelected,
  }) : super(key: key);

  @override
  State<TypeSound> createState() => _TypeSoundState();
}

class _TypeSoundState extends State<TypeSound> {
  String? selectedSound;

  // callback function para retornar el valor seleccionado
  void callbackreturnsound() {
    widget.onSoundSelected(selectedSound);
  }

  @override
  void initState() {
    super.initState();
    selectedSound = "Sound 1";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      // height: widget.height,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.titleVisible)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Seleccione un sonido',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: widget.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSoundCheckbox("Sound 1"),
                  _buildSoundCheckbox("Sound 2"),
                  _buildSoundCheckbox("Sound 3"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoundCheckbox(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          Radio<String>(
            fillColor: MaterialStateProperty.all(Colors.green),
            value: label,
            groupValue: selectedSound,
            onChanged: (String? value) {
              setState(() {
                selectedSound = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
