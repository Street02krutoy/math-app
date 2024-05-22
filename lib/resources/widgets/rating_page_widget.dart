import 'package:flutter/material.dart';
import 'package:flutter_app/resources/widgets/toast_notification_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  createState() => _RatingPageState();
}

class _RatingPageState extends NyState<RatingPage> {
  _RatingPageState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("rating.page_name".tr()),
      ),
      body: ToastNotification(ToastMeta(
          title: "title", style: "style", description: "description")),
    );
  }
}
