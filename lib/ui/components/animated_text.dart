import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimatedText extends StatefulWidget {
  final connection;
  final deviceConnected;
  const AnimatedText({super.key, this.connection, this.deviceConnected});

  @override
  AnimatedTextState createState() => AnimatedTextState();
}

class AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animacion;

  @override
  void initState() {
    super.initState();
    print("Conexion: ${widget.connection}");
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: false);
    _animacion = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: widget.connection != null
            ? LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 237, 43),
                  Color.fromARGB(255, 178, 180, 44)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: [
                  Color.fromARGB(255, 201, 3, 3),
                  Color.fromARGB(255, 183, 28, 28)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.deviceConnected != ""
              ? Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Device Connected to ${widget.deviceConnected}',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontFamily: 'LCD',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        FontAwesomeIcons.satelliteDish,
                        color: Colors.white,
                      )
                    ],
                  ),
                )
              : SlideTransition(
                  position: _animacion,
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          '<< No Device Connection >>',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontFamily: 'LCD',
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          FontAwesomeIcons.satelliteDish,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
