import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton(
      {super.key, required this.onTap, required this.text, required this.icon});
  final void Function()? onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Theme.of(context).cardColor,
        child: InkWell(
          splashColor: Theme.of(context).appBarTheme.backgroundColor,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 100,
              child: Center(
                  child: Row(children: [
                Text(text),
                Spacer(),
                Icon(
                  icon,
                )
              ])),
            ),
          ),
        ),
      ),
    );
  }
}
