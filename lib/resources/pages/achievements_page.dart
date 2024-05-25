import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class AchievementsPage extends NyStatefulWidget {
  static const path = '/achievements';

  AchievementsPage({super.key}) : super(path, child: _AchievementsPageState());
}

class _AchievementsPageState extends NyState<AchievementsPage> {
  @override
  init() async {}

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
        child: Container(),
      ),
    );
  }
}
