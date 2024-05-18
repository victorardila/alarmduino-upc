import 'package:flutter/material.dart';

class CustonSwitch extends StatefulWidget {
  final bluetooth;
  final bluetoothState;
  final onBluetoothStateChange;
  const CustonSwitch({
    Key? key, // Corrección: "super.key" a "Key? key"
    required this.bluetooth,
    required this.bluetoothState,
    required this.onBluetoothStateChange,
  }) : super(key: key); // Añadir super(key: key) aquí

  @override
  State<CustonSwitch> createState() => _CustonSwitchState();
}

class _CustonSwitchState extends State<CustonSwitch> {
  late var _bluetooth;
  bool _bluetoothState = false;

  @override
  void initState() {
    super.initState();
    _bluetooth = widget.bluetooth;
    _bluetoothState = widget.bluetoothState;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      value: _bluetoothState,
      onChanged: (bool value) async {
        if (value) {
          await _bluetooth.requestEnable();
        } else {
          await _bluetooth.requestDisable();
        }
        setState(() {
          _bluetoothState = value;
          widget.onBluetoothStateChange(value);
        });
      },
      activeColor: Color.fromARGB(255, 71, 52, 243),
      inactiveThumbColor: Color.fromARGB(255, 15, 59, 201),
      activeTrackColor: Colors.white,
      inactiveTrackColor: Color.fromARGB(255, 105, 147, 238),
      tileColor: Colors.black26,
      title: TextButton.icon(
        onPressed: () {},
        icon: Image.asset(
          'assets/img/bluetooth.png',
          width: 60,
          height: 60,
        ),
        label: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(
                text: 'Bluetooth ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: _bluetoothState ? 'Activado' : 'Desactivado',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      thumbColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors
                .white; // Color del icono del thumb cuando está seleccionado
          }
          return Colors
              .white; // Color del icono del thumb cuando no está seleccionado
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Color.fromARGB(
                255, 71, 52, 243); // Color del botón cuando está activado
          }
          return Color.fromARGB(
              255, 105, 147, 238); // Color del botón cuando está desactivado
        },
      ),
      // Agregar textura al toggle con BoxDecoration
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      mouseCursor: MaterialStateMouseCursor.clickable,
      selectedTileColor: Colors.black26,
      selected: _bluetoothState,
      visualDensity: VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      enableFeedback: true,
      hoverColor: Colors.black26,
    );
  }
}
