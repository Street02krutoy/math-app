import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/mixed_themes_page.dart';
import 'package:flutter_app/resources/pages/solve_page.dart';
import 'package:flutter_app/resources/pages/theme_info_page.dart';
import 'package:flutter_app/resources/widgets/theme_card_widget.dart';
import 'package:flutter_app/util/context_ext.dart';
import "package:flutter_app/app/networking/api_service.dart";
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

  final ApiService apiService = ApiService();

  @override
  init() async {
    if (themes == null) fetch();
  }

  fetch() {
    themes = apiService.getTopics();
  }

  @override
  boot() {
    return Scaffold(
      appBar: AppBar(
        title: Text("general.loading".tr()),
      ),
      body: Text("general.loading".tr()),
    );
  }

  static Future? themes;

  @override
  stateUpdated(dynamic data) async {
    // e.g. to update this state from another class
    // updateState(ThemesPage.state, data: "example payload");
  }

  void showDiffDialog(BuildContext context, int id, String placeholder,
      {bool is_mixed = false}) {
    showDialog(
        context: context,
        builder: ((context) => PopUpDifficulty(
              id: id,
              placeholder: placeholder,
              is_mixed: is_mixed,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("themes.page_name".tr()),
      ),
      body: FutureBuilder(
        future: themes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List themesList = snapshot.data!;
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  fetch();
                });
                await themes;
              },
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(
                  themesList.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ThemeCard(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(themesList[index]["name"]),
                              ),
                              InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                onTap: () async {
                                  apiService
                                      .getTopicDescription(
                                          themesList[index]["id"])
                                      .then((value) {
                                    routeTo(ThemeInfoPage.path, data: {
                                      "name": themesList[index]["name"],
                                      "description": value["description"]
                                    });
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      context.theme.colorScheme.secondary,
                                  child: Icon(
                                    Icons.question_mark,
                                    color: context.theme.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          content: Image.network(
                            getEnv("API_BASE_URL") +
                                "/api/user/topic_photo/" +
                                themesList[index]["id"].toString(),
                          ),
                          onTap: () {
                            showDiffDialog(context, themesList[index]["id"],
                                themesList[index]["placeholder"],
                                is_mixed: themesList[index]["id"] == 14);
                          },
                          height: 100),
                    );
                  },
                ),
              ),
            );
          }
          return Center(
            child: Column(
              children: [Spacer(), CircularProgressIndicator(), Spacer()],
            ),
          );
        },
      ),
    );
  }
}

class PopUpDifficulty extends StatefulWidget {
  PopUpDifficulty(
      {super.key,
      required this.id,
      required this.placeholder,
      this.is_mixed = false});

  final int id;
  final String placeholder;
  final bool is_mixed;

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
                  int complexity;
                  switch (_difficulty!) {
                    case Difficulty.easy:
                      complexity = 1;
                      break;
                    case Difficulty.medium:
                      complexity = 2;
                      break;
                    case Difficulty.hard:
                      complexity = 3;
                      break;
                  }
                  Navigator.pop(context, 'OK');
                  routeTo(
                      !widget.is_mixed ? SolvePage.path : MixedThemesPage.path,
                      data: {
                        "complexity": complexity,
                        "id": widget.id,
                        "placeholder": widget.placeholder
                      });
                },
          child: Text('general.ok'.tr()),
        ),
      ],
    );
  }
}
