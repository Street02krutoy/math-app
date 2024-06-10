import 'package:flutter/material.dart';
import 'package:flutter_app/resources/widgets/profile_button_widget.dart';
import 'package:flutter_app/util/context_ext.dart';
import 'package:nylo_framework/nylo_framework.dart';
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: InkWell(
                        onTap: () {
                          //TODO: theme selection
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "settings.theme".tr(),
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              "settings.dark".tr(),
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
                  ],
                ),
              ),
            ],
          ),
        ),
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
