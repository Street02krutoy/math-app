import 'package:flutter/widgets.dart';
import 'package:flutter_app/resources/widgets/round_image_widget.dart';
import 'package:flutter_app/resources/widgets/text_icon_button_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:nylo_framework/theme/helper/ny_theme.dart';
import 'package:flutter/material.dart';
import '/bootstrap/extensions.dart';
import '/resources/widgets/logo_widget.dart';
import '/resources/widgets/safearea_widget.dart';
import '/bootstrap/helpers.dart';
import '/app/controllers/home_controller.dart';

class HomePage extends NyStatefulWidget<HomeController> {
  static const path = '/home';

  HomePage({super.key}) : super(path, child: _HomePageState());
}

class _HomePageState extends NyState<HomePage> {
  /// The boot method is called before the [view] is rendered.
  /// You can override this method to perform any async operations.
  /// Try uncommenting the code below.
  // @override
  // boot() async {
  //   dump("boot");
  //   await Future.delayed(Duration(seconds: 2));
  // }

  /// If you would like to use the Skeletonizer loader,
  /// uncomment the code below.
  // bool get useSkeletonizer => true;

  /// The Loading widget is shown while the [boot] method is running.
  /// You can override this method to show a custom loading widget.
  // @override
  // Widget loading(BuildContext context) {
  //   return Scaffold(
  //       body: Center(child: Text("Loading..."))
  //   );
  // }

  /// The [view] method should display your page.
  @override
  Widget view(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("profile_page".tr()),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: widget.controller.login,
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
                    roundColor: theme.primaryColor,
                    radius: 60),
                Text(
                  "Name",
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: SizedBox(
                            height: 100,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.blue.shade600,
                                      size: 40,
                                    ),
                                    Text(
                                      "rating".tr(),
                                      style: theme.primaryTextTheme.labelLarge
                                          ?.apply(
                                              fontSizeDelta: 4,
                                              color: Colors.blue.shade600),
                                    )
                                  ],
                                ),
                                Text(
                                  "123",
                                  style: TextStyle(fontSize: 30),
                                )
                              ],
                            )),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.done,
                                    color: Colors.blue.shade600,
                                    size: 40,
                                  ),
                                  Text(
                                    "done".tr(),
                                    style: theme.primaryTextTheme.labelLarge
                                        ?.apply(
                                            fontSizeDelta: 4,
                                            color: Colors.blue.shade600),
                                  )
                                ],
                              ),
                              Text(
                                "123",
                                style: TextStyle(fontSize: 30),
                              )
                            ],
                          ),
                        ),
                      ),
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

  bool get isThemeDark =>
      ThemeProvider.controllerOf(context).currentThemeId ==
      getEnv('DARK_THEME_ID');
}
