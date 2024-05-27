import 'package:flutter/material.dart';

class AchievementWidget extends StatelessWidget {
  AchievementWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.image_url,
      required this.is_done});

  final String title, description, image_url;
  final bool is_done;
  late final Color title_color, color;

  void init(BuildContext context) {
    if (is_done) {
      title_color = Color.fromRGBO(255, 199, 0, 1);
      color = Theme.of(context).colorScheme.secondary;
    } else {
      title_color = Colors.white24;
      color = Theme.of(context).cardColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Text(
          title,
          textScaler: TextScaler.linear(2),
          style: TextStyle(
            color: title_color,
            fontSize: 14,
          ),
        ),
        leading: Image.network(
          image_url,
          width: 60,
          height: 60,
        ),
        subtitle: Text(
          description,
          textScaler: TextScaler.linear(2),
          style: TextStyle(
            color: Colors.black,
            fontSize: 10,
          ),
        ),
      ),
      color: color,
      shadowColor: Colors.transparent,
      borderOnForeground: true,
    );
  }
}
