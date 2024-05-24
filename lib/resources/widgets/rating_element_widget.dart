import 'package:flutter/material.dart';

class TopListItem extends StatelessWidget {
  const TopListItem({
    super.key,
    required this.place,
    required this.name,
    required this.rating,
    this.borderColor = null,
  });

  final int? place;
  final String? name;
  final num? rating;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
                color: borderColor == null
                    ? Theme.of(context).cardColor
                    : borderColor!)),
        title: Text(
          name.toString(),
          textScaler: TextScaler.linear(2),
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        leading: Text(
          place.toString(),
          textScaler: TextScaler.linear(2),
          // style: TextStyle(fontSize: 14,),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 5,
                bottom: 2,
              ),
              child: Icon(
                Icons.star,
                color: Colors.yellow,
              ),
            ),
            Text(
              rating.toString(),
              textScaler: TextScaler.linear(2),
              style: TextStyle(
                fontSize: 14,
              ),
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
