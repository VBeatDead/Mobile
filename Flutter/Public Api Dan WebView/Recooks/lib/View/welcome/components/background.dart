import 'package:flutter/material.dart';

class Background extends StatelessWidget{
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: -2,
            left: -80,
            child: Image.asset(
              "assets/images/side1.png",
              width: size.width * 0.6,
            ),
          ),
          Positioned(
            top: -5,
            right: -80,
            child: Image.asset(
              "assets/images/side2.png",
              width: size.width * 0.7,
            ),
          ),
          child,
        ],
      ),
    );
  }
}