import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,
      required this.title,
      required this.content,
      this.onTap = null,
      required this.height});
  final Widget title;

  final Widget content;
  final double height;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: height,
            child: Column(
              children: [title, content],
            ),
          ),
        ),
      ),
    );
  }
}
