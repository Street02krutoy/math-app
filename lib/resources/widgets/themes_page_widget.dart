import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/resources/widgets/custom_card_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ThemesPage extends StatefulWidget {
  const ThemesPage({super.key});

  static String state = "themes_page";

  @override
  createState() => _ThemesPageState();
}

class _ThemesPageState extends NyState<ThemesPage> {
  _ThemesPageState() {
    stateName = ThemesPage.state;
  }

  List<Widget> themes = List.generate(21, (index) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CustomCard(
          title: "title",
          content: Text("description"),
          onTap: () {},
          height: 100),
    );
  });

  @override
  init() async {}

  @override
  boot() {
    return Scaffold(
      appBar: AppBar(
        title: Text("loading".tr()),
      ),
      body: Text("loading".tr()),
    );
  }

  @override
  stateUpdated(dynamic data) async {
    // e.g. to update this state from another class
    // updateState(ThemesPage.state, data: "example payload");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("themes_page".tr()),
      ),
      body: GridView.count(crossAxisCount: 2, children: themes),
    );
  }
}
