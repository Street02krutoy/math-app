import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProgressWidget extends StatefulWidget {
  final String title;

  final int done;

  const ProgressWidget({super.key, required this.title, required this.done});

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Text(
          widget.title,
          textScaler: TextScaler.linear(2),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
            "progress.done".tr(arguments: {"done": widget.done.toString()})),
      ),
      color: Theme.of(context).cardColor,
      shadowColor: Colors.transparent,
      borderOnForeground: true,
    );
  }
}
