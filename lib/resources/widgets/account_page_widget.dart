import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/app/controllers/account_controller.dart';
import 'package:flutter_app/app/controllers/home_controller.dart';
import 'package:flutter_app/resources/widgets/custom_card_widget.dart';
import 'package:flutter_app/resources/widgets/round_image_widget.dart';
import 'package:flutter_app/resources/widgets/text_icon_button_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../app/controllers/controller.dart';

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
          title: Text("profile_page".tr()),
          actions: [
            IconButton(
              onPressed: AccountController().login,
              icon: const Icon(Icons.login),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                RoundImage(
                    child: SizedBox(
                      height: 600,
                      width: 600,
                      child: Container(
                        color: theme.cardColor,
                      ),
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
                          title: "rating".tr(),
                          content: Text(
                            "123",
                            textScaler: TextScaler.linear(2),
                          ),
                          onTap: () {},
                          height: 75),
                    ),
                    Expanded(
                      child: CustomCard(
                          title: "done".tr(),
                          content: Text(
                            "123",
                            textScaler: TextScaler.linear(2),
                          ),
                          onTap: () {},
                          height: 75),
                    )
                  ],
                ),
                TextIconButton(
                    onTap: () async {
                      await changeLanguage('en');
                    },
                    text: "achievements".tr(),
                    icon: Icons.arrow_right),
                TextIconButton(
                    onTap: () {},
                    text: "progress".tr(),
                    icon: Icons.arrow_right),
                TextIconButton(
                    onTap: () {},
                    text: "list_of_themes".tr(),
                    icon: Icons.arrow_right),
                Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                        onPressed: () async {
                          await changeLanguage('ru');
                        },
                        child: Row(
                          children: [Icon(Icons.logout), Text("logout".tr())],
                        )),
                    Spacer()
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
