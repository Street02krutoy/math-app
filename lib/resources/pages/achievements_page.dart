import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter_app/resources/widgets/achievement_widget.dart';

class AchievementsPage extends NyStatefulWidget {
  static const path = '/achievements';

  AchievementsPage({super.key}) : super(path, child: _AchievementsPageState());
}

class _AchievementsPageState extends NyState<AchievementsPage> {
  late final List<Map> achievements;

  @override
  init() async {
    achievements = List.generate(
      20,
      (index) => {
        "title": "Achievement",
        "description": "fdksfaksfjaklsadfskjjjjjjjjjjjjjjjjdddddddddddfdjasfk",
        "image_url":
            "https://files.vgtimes.ru/achievements/90751/3e39a89a4220a03bff325d1c36ad7d8a.jpg",
        "is_done": index > 10 ? false : true,
      },
    );
  }

  /// Use boot if you need to load data before the [view] is rendered.
  // @override
  // boot() async {
  //
  // }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("achievements.page_name".tr())),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: achievements.length,
                  itemBuilder: (context, index) => AchievementWidget(
                      title: achievements[index]["title"],
                      description: achievements[index]["description"],
                      child: ImageFiltered(
                        imageFilter: achievements[index]["is_done"]
                            ? ImageFilter.blur()
                            : ImageFilter.blur(
                                sigmaX: 5, sigmaY: 5, tileMode: TileMode.decal),
                        child: Image.network(
                          achievements[index]["image_url"],
                          width: 60,
                          height: 60,
                        ),
                      ),
                      done: achievements[index]["is_done"]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
