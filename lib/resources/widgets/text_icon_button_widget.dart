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
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
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
