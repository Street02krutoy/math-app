import 'package:flutter/material.dart';
import 'package:flutter_app/app/networking/api_service.dart';
import 'package:flutter_app/resources/pages/achievements_page.dart';
import 'package:flutter_app/resources/pages/progress_page.dart';
import 'package:flutter_app/resources/pages/settings_page.dart';
import 'package:flutter_app/resources/widgets/custom_card_widget.dart';
import 'package:flutter_app/resources/widgets/profile_button_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_app/util/pick_photo_service.dart';

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

  final ApiService apiService = ApiService();

  @override
  init() async {
    fetch();
  }

  @override
  stateUpdated(dynamic data) async {
    // e.g. to update this state from another class
    // updateState(AccountPage.state, data: "example payload");
  }

  static Future? userf;

  fetch() {
    userf = apiService.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("profile.page_name".tr()),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.edit),
          //   onPressed: () {
          //     // routeTo(TestPage.path);
          //   },
          // )
        ],
      ),
      body: FutureBuilder(
        future: userf,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map user = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomCard(
                            title: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                ClipOval(
                                  child: CircleAvatar(
                                    child: Image.network(
                                      getEnv("API_BASE_URL") +
                                          "/api/user/leader_photo/" +
                                          user["id"],
                                    ),
                                    radius: 60,
                                    backgroundColor:
                                        Theme.of(context).canvasColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    UploadPhotoService(context)
                                        .showUploadDialog();
                                  },
                                  icon: Icon(Icons.add_a_photo_sharp),
                                ),
                              ],
                            ),
                            content: Text(
                              Auth.user() != null
                                  ? Auth.user()["preferred_username"]
                                  : "Error",
                              textScaler: TextScaler.linear(2),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomCard(
                                      title: Text(
                                        "profile.rating".tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 2),
                                            child: Icon(
                                              Icons.star,
                                              size: 15,
                                              color:
                                                  Theme.of(context).focusColor,
                                            ),
                                          ),
                                          Text(
                                            user["rating"].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ],
                                      ),
                                      height: 60,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomCard(
                                      title: Text(
                                        "profile.top".tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      content: Text(
                                        user["place_in_top"].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      height: 60,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: ProfileButtonWidget(
                        height: 87,
                        title: Text("profile.progress.page_name".tr()),
                        subtitle: Text("profile.progress.description".tr()),
                        icon: Icons.trending_up,
                        onTap: () {
                          routeTo(ProgressPage.path);
                        },
                      ),
                    ),
                    Expanded(
                      child: ProfileButtonWidget(
                        height: 87,
                        title: Text("profile.achievements.page_name".tr()),
                        subtitle: Text("profile.achievements.description".tr()),
                        icon: Icons.offline_pin,
                        onTap: () {
                          routeTo(AchievementsPage.path);
                        },
                      ),
                    ),
                    Expanded(
                      child: ProfileButtonWidget(
                        height: 87,
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
                    ),
                    Expanded(
                      child: ProfileButtonWidget(
                        height: 87,
                        title: Text(
                          "profile.support.page_name".tr(),
                        ),
                        subtitle: Text(
                          "profile.support.description".tr(),
                        ),
                        icon: Icons.contact_support,
                        onTap: () {
                          launchUrl(Uri.parse("https://t.me/tmathsupportbot"));
                        },
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
        },
      ),
    );
  }
}
