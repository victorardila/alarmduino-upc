import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText({super.key});

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
      color: Colors.red[900],
      child: Row(
        children: [
          SlideTransition(
            position: _animacion,
            child: const Center(
              child: Row(
                children: [
                  Text(
                    '<No Device Connection>',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'LCD',
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    FontAwesomeIcons.satelliteDish,
                    color: Colors.white,
                    size: 20.0,
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
