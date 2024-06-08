import 'package:flutter/material.dart';

class AchievementWidget extends StatelessWidget {
  AchievementWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.child,
      required this.done});

  final String title, description;
  final Widget child;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Text(
          title,
          textScaler: TextScaler.linear(2),
          style: TextStyle(
            color: done
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).disabledColor,
            fontSize: 14,
          ),
        ),
        leading: child,
        subtitle: Text(
          description,
          textScaler: TextScaler.linear(2),
          style: TextStyle(
            fontSize: 10,
          ),
        ),
      ),
      color: Theme.of(context).cardColor,
      shadowColor: Colors.transparent,
      borderOnForeground: true,
    );
  }
}
