import 'package:flutter/material.dart';

class KeyboardButtonWidget extends StatelessWidget {
  const KeyboardButtonWidget(
      {super.key,
      required this.text,
      required this.controller,
      required this.context});

  final String text;
  final TextEditingController controller;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text(
        text,
        textScaler: TextScaler.linear(2),
      ),
      style: ButtonStyle(
        backgroundColor:
            WidgetStatePropertyAll<Color>(Theme.of(context).cardColor),
      ),
      onPressed: () {
        controller.text += text;
      },
    );
  }
}
