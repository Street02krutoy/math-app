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

  List<Map> rating = [];

  @override
  void initState() {
    for (int i = 1; i < 101; i++) {
      rating.add({"position": i, "name": "User", "rating": 200 - i});
    }
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("rating.page_name".tr()),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ProfileTop(
                place: 2,
                name: "User",
                child: Container(
                  color: theme.cardColor,
                ),
                rating: 58.2,
              ),
              ProfileTop(
                place: 1,
                name: "User",
                child: Container(
                  color: theme.cardColor,
                ),
                rating: 58.2,
              ),
              ProfileTop(
                place: 3,
                name: "User",
                child: Container(
                  color: theme.cardColor,
                ),
                rating: 58.2,
              )
            ],
          ),
        ],
      ),
    );
  }
}
