import 'package:flutter/material.dart';

class ProfileButtonWidget extends StatelessWidget {
  const ProfileButtonWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.height,
    this.onTap = null,
  });

  final Widget title, subtitle, icon;
  final double height;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: height,
        child: Card(
          child: Center(
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              title: title,
              subtitle: subtitle,
              trailing: icon,
            ),
          ),
          color: Theme.of(context).cardColor,
          shadowColor: Colors.transparent,
        ),
      ),
    );
  }
}
