import 'package:flutter/material.dart';
import 'package:flutter_app/resources/widgets/top_image_widgets.dart';
import 'package:flutter_app/resources/widgets/custom_card_widget.dart';
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
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("rating.page_name".tr()),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ProfileTop2(
            name: "User",
            child: Container(
              color: theme.cardColor,
            ),
            rating: 58.2,
          ),
          ProfileTop1(
            name: "User",
            child: Container(
              color: theme.cardColor,
            ),
            rating: 58.2,
          ),
          ProfileTop3(
            name: "User",
            child: Container(
              color: theme.cardColor,
            ),
            rating: 58.2,
          )
        ],
      ),
    );
  }
}
