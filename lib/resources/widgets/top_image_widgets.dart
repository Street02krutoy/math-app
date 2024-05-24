import 'package:flutter/material.dart';
import 'package:flutter_app/resources/widgets/round_image_widget.dart';

class ProfileTop extends StatelessWidget {
  ProfileTop(
      {super.key,
      required this.child,
      required this.rating,
      required this.name,
      required this.place});

  final String name;
  final Widget child;
  final num rating;
  final int place;
  late final Color color;
  late final String path;
  late final double radius;

  void init() {
    switch (place) {
      case 1:
        color = Color.fromRGBO(255, 199, 0, 1);
        path = "public/assets/images/top1_icon.png";
        radius = 60;
        break;
      case 2:
        color = Color.fromRGBO(147, 147, 147, 1);
        path = "public/assets/images/top2_icon.png";
        radius = 50;
        break;
      case 3:
        color = Color.fromRGBO(168, 100, 0, 1);
        path = "public/assets/images/top3_icon.png";
        radius = 50;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: RoundImage(
                child: child,
                roundColor: color,
                radius: radius,
              ),
            ),
            Image.asset(path),
          ],
          alignment: AlignmentDirectional.bottomCenter,
        ),
        Text(
          name,
          textScaler: TextScaler.linear(2),
        ),
        Row(
          children: [
            Image.asset(
              "public/assets/images/star.png",
              width: 25,
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
            ),
            Text(
              rating.toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        )
      ],
    );
  }
}
