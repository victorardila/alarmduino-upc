import 'package:flutter/material.dart';

class CustonSwitch extends StatefulWidget {
  final bluetooth;
  final bluetoothState;
  const CustonSwitch({
    super.key,
    this.bluetooth,
    this.bluetoothState,
  });

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
    return SwitchListTile(
      value: _bluetoothState,
      onChanged: (bool value) async {
        if (value) {
          await _bluetooth.requestEnable();
        } else {
          await _bluetooth.requestDisable();
        }
      },
      tileColor: Colors.black26,
      title: TextButton.icon(
        onPressed: () {},
        icon: Icon(
          _bluetoothState ? Icons.bluetooth : Icons.bluetooth_disabled,
          color: Colors.white,
        ),
        label: Text(
          _bluetoothState ? 'Bluetooth Activado' : 'Bluetooth Desactivado',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }
}
