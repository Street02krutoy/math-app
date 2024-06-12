import 'package:flutter/material.dart';

class ThemeCard extends StatelessWidget {
  const ThemeCard(
      {super.key,
      required this.title,
      required this.content,
      this.onTap = null,
      this.height,
      this.width});

  final Widget title;

  final Widget content;
  final double? height;
  final double? width;
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
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                title,
                Spacer(),
                content,
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
