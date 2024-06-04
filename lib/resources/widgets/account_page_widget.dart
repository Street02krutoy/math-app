import 'package:flutter/material.dart';
import 'package:flutter_app/app/networking/api_service.dart';
import 'package:flutter_app/app/providers/auth_provider.dart';
import 'package:flutter_app/resources/pages/achievements_page.dart';
import 'package:flutter_app/resources/pages/progress_page.dart';
import 'package:flutter_app/resources/pages/settings_page.dart';
import 'package:flutter_app/resources/widgets/custom_card_widget.dart';
import 'package:flutter_app/resources/widgets/profile_button_widget.dart';
import 'package:flutter_app/resources/widgets/round_image_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:url_launcher/url_launcher.dart';

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
          actions: [],
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
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: Theme.of(context).focusColor,
                              ),
                              Text(
                                "profile.rating".tr(),
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          content: Text(
                            "123",
                            textScaler: TextScaler.linear(2),
                          ),
                          height: 75),
                    ),
                    Expanded(
                      child: CustomCard(
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check,
                                color: Theme.of(context).focusColor,
                              ),
                              Text(
                                "profile.done".tr(),
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          content: Text(
                            "123",
                            textScaler: TextScaler.linear(2),
                          ),
                          height: 75),
                    ),
                  ],
                ),
                ProfileButtonWidget(
                  height: 95,
                  title: Text("profile.progress.page_name".tr()),
                  subtitle: Text("profile.progress.description".tr()),
                  icon: Icons.trending_up,
                  onTap: () {
                    routeTo(ProgressPage.path);
                  },
                ),
                ProfileButtonWidget(
                  height: 95,
                  title: Text("profile.achievements.page_name".tr()),
                  subtitle: Text("profile.achievements.description".tr()),
                  icon: Icons.offline_pin,
                  onTap: () {
                    routeTo(AchievementsPage.path);
                  },
                ),
                ProfileButtonWidget(
                  height: 95,
                  title: Text(
                    "profile.settings.page_name".tr(),
                  ),
                  subtitle: Text(
                    "profile.settings.description".tr(),
                  ),
                  icon: Icons.settings,
                  onTap: () {
                    routeTo(SettingsPage.path);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
