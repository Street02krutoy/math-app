import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/rating.dart';
import 'package:flutter_app/resources/widgets/top_image_widgets.dart';
import 'package:nylo_framework/nylo_framework.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  createState() => _RatingPageState();
}

class _RatingPageState extends NyState<RatingPage> {
  _RatingPageState() {}

  List<Rating> rating = [];

  @override
  void initState() {
    rating = List.generate(100, (index) {
      return Rating("Name", index.toDouble(), index);
    });
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
