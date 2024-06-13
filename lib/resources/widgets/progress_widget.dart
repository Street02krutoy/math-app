import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/progress_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProgressWidget extends StatefulWidget {
  final String title;

  final DoneLevels done;
  final Color color;

  const ProgressWidget(
      {super.key,
      required this.title,
      required this.done,
      required this.color});

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  List<DoughnutData>? dataSource;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      triggerMode: TooltipTriggerMode.tap,
      message: "${"progress.done.easy".tr(arguments: {
            "done": widget.done.easy.toString()
          })}, ${"progress.done.medium".tr(arguments: {
            "done": widget.done.medium.toString()
          })}, ${"progress.done.hard".tr(arguments: {
            "done": widget.done.hard.toString()
          })}",
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
              child: Text(
                widget.title,
                textScaler: TextScaler.linear(2),
                style: TextStyle(
                  color: widget.color,
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              widget.done.all.toString(),
              textScaler: TextScaler.linear(2),
            )
          ]),
        ),
        color: Theme.of(context).cardColor,
        shadowColor: Colors.transparent,
        borderOnForeground: true,
      ),
    );
  }
}

class DoneLevels {
  final int easy;
  final int medium;
  final int hard;
  final int all;

  const DoneLevels(
      {required this.easy,
      required this.medium,
      required this.hard,
      required this.all});
}
