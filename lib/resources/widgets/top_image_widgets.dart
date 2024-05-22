import 'package:flutter/material.dart';
import 'package:flutter_app/resources/widgets/round_image_widget.dart';

class ProfileTop1 extends StatelessWidget {
  const ProfileTop1({super.key, required this.child, required this.rating, required this.name});

  final String name;
  final Widget child;
  final num rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: RoundImage(
                child: child,
                roundColor: Color.fromRGBO(255, 199, 0, 1),
                radius: 60,
              ),
            ),
            Image.asset("public/assets/images/top1_icon.png"),
          ],
          alignment: AlignmentDirectional.bottomCenter,
        ),
        Text(
          name,
          textScaler: TextScaler.linear(2),
        ),
        Row(
          children: [
            Image.asset("public/assets/images/star.png", width: 25, height: 25,),
            Padding(padding: EdgeInsets.only(right: 10),),
            Text(rating.toString(), style: TextStyle(fontSize: 20,),),
          ],
        )
      ],
    );
  }
}

class ProfileTop2 extends StatelessWidget {
  const ProfileTop2({super.key, required this.child, required this.rating, required this.name});

  final String name;
  final Widget child;
  final num rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: RoundImage(
                child: child,
                roundColor: Color.fromRGBO(147, 147, 147, 1),
                radius: 50,
              ),
            ),
            Image.asset("public/assets/images/top2_icon.png"),
          ],
          alignment: AlignmentDirectional.bottomCenter,
        ),
        Text(
          name,
          textScaler: TextScaler.linear(2),
        ),
        Row(
          children: [
            Image.asset("public/assets/images/star.png", width: 25, height: 25,),
            Padding(padding: EdgeInsets.only(right: 10),),
            Text(rating.toString(), style: TextStyle(fontSize: 20,),),
          ],
        )
      ],
    );
  }
}

class ProfileTop3 extends StatelessWidget {
  const ProfileTop3({super.key, required this.child, required this.rating, required this.name});

  final String name;
  final Widget child;
  final num rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: RoundImage(
                child: child,
                roundColor: Color.fromRGBO(168, 100, 0, 1),
                radius: 50,
              ),
            ),
            Image.asset("public/assets/images/top3_icon.png"),
          ],
          alignment: AlignmentDirectional.bottomCenter,
        ),
        Text(
          name,
          textScaler: TextScaler.linear(2),
        ),
        Row(
          children: [
            Image.asset("public/assets/images/star.png", width: 25, height: 25,),
            Padding(padding: EdgeInsets.only(right: 10),),
            Text(rating.toString(), style: TextStyle(fontSize: 20,),),
          ],
        )
      ],
    );
  }
}
