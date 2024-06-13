import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/app/networking/api_service.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/resources/pages/home_page.dart';
import 'package:flutter_app/resources/widgets/profile_button_widget.dart';
import 'package:flutter_app/util/context_ext.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:nylo_framework/theme/helper/ny_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends NyStatefulWidget {
  static const path = '/settings';

  SettingsPage({super.key}) : super(path, child: _SettingsPageState());
}

class _SettingsPageState extends NyState<SettingsPage> {
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
      appBar: AppBar(
        title: Text("settings.page_name".tr()),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            16.0,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(
                  10.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                  color: Theme.of(context).cardColor,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "settings.general".tr(),
                      textScaler: TextScaler.linear(2),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: InkWell(
                        //TODO: make splashColor work
                        onTap: () {
                          showDialog(
                              builder: (context) =>
                                  showLaunguageDialog(context),
                              context: context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "settings.language".tr(),
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              "settings.selected_language".tr(),
                              style: TextStyle(
                                color: Theme.of(context).disabledColor,
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     vertical: 10.0,
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         isThemeDark
                    //             ? "settings.theme.dark".tr()
                    //             : "settings.theme.light".tr(),
                    //         style: TextStyle(
                    //           fontSize: 24,
                    //         ),
                    //       ),
                    //       Switch(
                    //           value: isThemeDark,
                    //           onChanged: (_) {
                    //             NyTheme.set(context,
                    //                 id: getEnv(isThemeDark != true
                    //                     ? 'DARK_THEME_ID'
                    //                     : 'LIGHT_THEME_ID'));
                    //             setState(() {});
                    //             dump(ThemeProvider.controllerOf(context)
                    //                 .currentThemeId);
                    //           }),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        ApiService().logout();
                        pop();
                        //HomePage.restartApp(context);
                      },
                      child: Text("settings.logout".tr())),
                  Spacer()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool get isThemeDark =>
      ThemeProvider.controllerOf(context).currentThemeId ==
      getEnv('DARK_THEME_ID');

  Widget showThemeDialog(BuildContext context) {
    return AlertDialog(
      title: Text("profile.themedialog.title".tr()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () async {
              context.nav.pop();
              NyTheme.set(context, id: getEnv('LIGHT_THEME_ID'));
              setState(() {});
            },
            child: Text(
              "profile.themedialog.light".tr(),
            ),
          ),
          TextButton(
            onPressed: () async {
              context.nav.pop();
              NyTheme.set(context, id: getEnv('DARK_THEME_ID'));
              setState(() {});
            },
            child: Text(
              "profile.themedialog.dark".tr(),
            ),
          ),
        ],
      ),
    );
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
              NyStorage.store("com.srit.math.lang", "ru");
            },
            child: Text(
              "profile.langdialog.ru".tr(),
            ),
          ),
          TextButton(
            onPressed: () async {
              context.nav.pop();
              await changeLanguage('en');
              NyStorage.store("com.srit.math.lang", "en");
            },
            child: Text(
              "profile.langdialog.en".tr(),
            ),
          ),
        ],
      ),
    );
  }
}
