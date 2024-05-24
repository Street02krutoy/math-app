import 'package:flutter/material.dart';

class TopListItem extends StatelessWidget {
  const TopListItem({
    super.key,
    required this.place,
    required this.name,
    required this.rating,
    this.borderColor = Colors.black,
  });

  final int? place;
  final String? name;
  final num? rating;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: borderColor)),
        title: Text(
          name.toString(),
          textScaler: TextScaler.linear(2),
          style: TextStyle(fontSize: 14,),
        ),
        leading: Text(
          place.toString(),
          textScaler: TextScaler.linear(2),
          // style: TextStyle(fontSize: 14,),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "public/assets/images/star.png",
              width: 25,
              height: 25,
            ),
            Text(
              rating.toString(),
              textScaler: TextScaler.linear(2),
              style: TextStyle(fontSize: 14,),
            ),
          ],
        ),
      ),
      color: Theme.of(context).cardColor,
      shadowColor: Colors.transparent,
      borderOnForeground: true,
    );
  }
}
