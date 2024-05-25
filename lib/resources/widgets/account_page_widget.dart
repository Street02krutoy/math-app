import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/account_controller.dart';
import 'package:flutter_app/resources/pages/achievements_page.dart';
import 'package:flutter_app/resources/pages/progress_page.dart';
import 'package:flutter_app/resources/pages/reference_page.dart';
import 'package:flutter_app/resources/widgets/custom_card_widget.dart';
import 'package:flutter_app/resources/widgets/round_image_widget.dart';
import 'package:flutter_app/resources/widgets/text_icon_button_widget.dart';
import 'package:flutter_app/util/context_ext.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:nylo_framework/theme/helper/ny_theme.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  static String state = "account_page";

  @override
  createState() => _AccountPageState();
}

class _AccountPageState extends NyState<AccountPage> {
  _AccountPageState() {
    stateName = AccountPage.state;
  }

  @override
  init() async {}

  @override
  stateUpdated(dynamic data) async {
    // e.g. to update this state from another class
    // updateState(AccountPage.state, data: "example payload");
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("profile.page_name".tr()),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    builder: (context) => showLaunguageDialog(context),
                    context: context);
              },
              icon: const Icon(Icons.language),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                RoundImage(
                    child: Container(
                      color: theme.cardColor,
                    ),
                    roundColor: theme.cardColor,
                    radius: 60),
                Text(
                  "Name",
                  textScaler: TextScaler.linear(2),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomCard(
                          title: Text("profile.rating".tr()),
                          content: Text(
                            "123",
                            textScaler: TextScaler.linear(2),
                          ),
                          height: 75),
                    ),
                    Expanded(
                      child: CustomCard(
                          title: Text("profile.done".tr()),
                          content: Text(
                            "123",
                            textScaler: TextScaler.linear(2),
                          ),
                          height: 75),
                    )
                  ],
                ),
                TextIconButton(
                    onTap: () {
                      routeTo(AchievementsPage.path);
                    },
                    text: "profile.achievements".tr(),
                    icon: Icons.arrow_right),
                TextIconButton(
                    onTap: () {
                      routeTo(ProgressPage.path);
                    },
                    text: "profile.progress".tr(),
                    icon: Icons.arrow_right),
                TextIconButton(
                    onTap: () {
                      routeTo(ReferencePage.path);
                    },
                    text: "profile.list_of_themes".tr(),
                    icon: Icons.arrow_right),
                Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                        onPressed: () async {},
                        child: Row(
                          children: [
                            Icon(Icons.logout),
                            Text("profile.logout".tr())
                          ],
                        )),
                    Spacer()
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget showLaunguageDialog(BuildContext context) {
    return AlertDialog(
        title: Text("profile.langdialog.title".tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
                onPressed: () async {
                  context.nav.pop();
                  await changeLanguage('ru');
                },
                child: Text("profile.langdialog.ru".tr())),
            TextButton(
                onPressed: () async {
                  context.nav.pop();
                  await changeLanguage('en');
                },
                child: Text("profile.langdialog.en".tr()))
          ],
        ));
  }
}
