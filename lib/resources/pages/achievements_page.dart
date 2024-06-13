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
  init() async {
    fetch();
  }

  /// Use boot if you need to load data before the [view] is rendered.
  // @override
  // boot() async {
  //
  // }

  fetch() {
    achievementsf = apiService.getAchievements();
  }

  static Future? achievementsf;

  @override
  Widget view(BuildContext context) {
    fetch();
    return Scaffold(
        appBar: AppBar(title: Text("achievements.page_name".tr())),
        body: FutureBuilder(
            future: achievementsf,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List achievements = snapshot.data;
                return SafeArea(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        fetch();
                      });
                      await achievementsf;
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: achievements.length,
                        itemBuilder: (context, index) => AchievementWidget(
                            title: achievements[index]["name"],
                            description: achievements[index]["description"],
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
                            done: achievements[index]["unlocked"] == 0
                                ? false
                                : true),
                      ),
                    ),
                  ),
                );
              }
              if (snapshot.hasError)
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("error"),
                        content: Text(snapshot.error.toString()),
                      );
                    },
                    barrierDismissible: false);
              return Center(
                child: Column(
                  children: [Spacer(), CircularProgressIndicator(), Spacer()],
                ),
              );
            }));
  }
}
