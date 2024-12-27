import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon(
      {super.key,
      required this.iconSize,
      required this.circleSize,
      required this.circleRadius,
      required this.imagePath,
      required this.iconColor,
      required this.circleColor});
  final iconSize;
  final circleSize;
  final circleRadius;
  final iconColor;
  final circleColor;
  final imagePath;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: 42,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(circleRadius)),
          child: Container(
              color: circleColor,
              child: Center(
                child: SizedBox(
                  height: iconSize,
                  width: iconSize,
                  child: Image.asset(
                    imagePath,
                    color: iconColor,
                    fit: BoxFit.contain,
                  ),
                ),
              ))),
    );
  }
}

class ListIcon extends CircleIcon {
  const ListIcon({
    super.key,
    required super.circleColor,
    required super.iconColor,
    super.circleRadius = 21.0,
    super.circleSize = 42.0,
    super.iconSize = 24.0,
    required super.imagePath,
  });
}
