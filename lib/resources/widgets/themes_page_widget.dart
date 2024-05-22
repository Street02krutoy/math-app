import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/resources/pages/solve_page.dart';
import 'package:flutter_app/resources/widgets/custom_card_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ThemesPage extends StatefulWidget {
  const ThemesPage({super.key});

  static String state = "themes_page";

  @override
  createState() => _ThemesPageState();
}

enum Difficulty { easy, medium, hard }

class _ThemesPageState extends NyState<ThemesPage> {
  _ThemesPageState() {
    stateName = ThemesPage.state;
  }

  @override
  init() async {}

  @override
  boot() {
    return Scaffold(
      appBar: AppBar(
        title: Text("general.loading".tr()),
      ),
      body: Text("general.loading".tr()),
    );
  }

  @override
  stateUpdated(dynamic data) async {
    // e.g. to update this state from another class
    // updateState(ThemesPage.state, data: "example payload");
  }

  void showDiffDialog(BuildContext context) {
    showDialog(context: context, builder: ((context) => PopUpDifficulty()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("themes.page_name".tr()),
      ),
      body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(21, (index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: CustomCard(
                  title: Text("title"),
                  content: Text("description"),
                  onTap: () {
                    showDiffDialog(context);
                  },
                  height: 100),
            );
          })),
    );
  }
}

class PopUpDifficulty extends StatefulWidget {
  PopUpDifficulty({super.key});

  @override
  State<PopUpDifficulty> createState() => _PopUpDifficultyState();
}

class _PopUpDifficultyState extends NyState<PopUpDifficulty> {
  Difficulty? _difficulty = null;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('themes.difficulty.choose'.tr()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<Difficulty>(
            activeColor: Theme.of(context).colorScheme.secondary,
            title: Text('themes.difficulty.0'.tr()),
            value: Difficulty.easy,
            groupValue: _difficulty,
            onChanged: (Difficulty? value) {
              setState(() {
                _difficulty = value;
              });
            },
          ),
          RadioListTile<Difficulty>(
            activeColor: Theme.of(context).colorScheme.secondary,
            title: Text('themes.difficulty.1'.tr()),
            value: Difficulty.medium,
            groupValue: _difficulty,
            onChanged: (Difficulty? value) {
              setState(() {
                _difficulty = value;
              });
            },
          ),
          RadioListTile<Difficulty>(
            activeColor: Theme.of(context).colorScheme.secondary,
            title: Text('themes.difficulty.2'.tr()),
            value: Difficulty.hard,
            groupValue: _difficulty,
            onChanged: (Difficulty? value) {
              setState(() {
                _difficulty = value;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text('general.cancel'.tr()),
        ),
        TextButton(
          onPressed: _difficulty == null
              ? null
              : () {
                  Navigator.pop(context, 'OK');
                  routeTo(SolvePage.path);
                },
          child: Text('general.ok'.tr()),
        ),
      ],
    );
  }
}
