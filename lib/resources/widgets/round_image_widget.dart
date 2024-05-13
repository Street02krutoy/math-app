import 'package:flutter/material.dart';

class RoundImage extends StatelessWidget {
  const RoundImage(
      {super.key,
      required this.child,
      required this.roundColor,
      required this.radius});

  final Widget child;
  final Color roundColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: roundColor,
      child: Padding(
        padding: const EdgeInsets.all(8), // Border radius
        child: ClipOval(child: child),
      ),
    );
  }
}
