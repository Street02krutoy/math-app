import 'dart:ui';
import "package:flutter_app/app/networking/api_service.dart";
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter_app/resources/widgets/achievement_widget.dart';

class AchievementsPage extends NyStatefulWidget {
  static const path = '/achievements';

  AchievementsPage({super.key}) : super(path, child: _AchievementsPageState());
}

class _AchievementsPageState extends NyState<AchievementsPage> {
  ApiService apiService = ApiService();

  @override
  init() async {}

  /// Use boot if you need to load data before the [view] is rendered.
  // @override
  // boot() async {
  //
  // }

  @override
  Widget view(BuildContext context) {
    Future achievementsf = apiService.getAchievements();
    return Scaffold(
        appBar: AppBar(title: Text("achievements.page_name".tr())),
        body: FutureBuilder(
            future: achievementsf,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List achievements = snapshot.data;
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: achievements.length,
                            itemBuilder: (context, index) => Expanded(
                              child: AchievementWidget(
                                  title: achievements[index]["name"],
                                  description: achievements[index]
                                      ["description"],
                                  child: ImageFiltered(
                                    imageFilter: achievements[index]["unlocked"] == 1
                                        ? ImageFilter.blur()
                                        : ImageFilter.blur(
                                            sigmaX: 5,
                                            sigmaY: 5,
                                            tileMode: TileMode.decal),
                                    child: Image.network(
                                      getEnv("API_BASE_URL") +
                                          "/api/user/achievement_photo/" +
                                          achievements[index]["id"].toString(),
                                      width: 60,
                                      height: 60,
                                    ),
                                  ),
                                  done: achievements[index]["unlocked"] == 0 ? false : true),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: Column(
                  children: [Spacer(), CircularProgressIndicator(), Spacer()],
                ),
              );
            }));
  }
}
