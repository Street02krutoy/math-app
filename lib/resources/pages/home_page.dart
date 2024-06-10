import 'package:flutter/material.dart';
import 'package:flutter_app/app/networking/api_service.dart';
import 'package:flutter_app/resources/pages/login_page.dart';
import 'package:flutter_app/resources/widgets/account_page_widget.dart';
import 'package:flutter_app/resources/widgets/rating_page_widget.dart';
import 'package:flutter_app/resources/widgets/themes_page_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

class HomePage extends NyStatefulWidget {
  static const path = '/home-page';

  HomePage({super.key}) : super(path, child: _HomePagePageState());
}

class _HomePagePageState extends NyState<HomePage> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    AccountPage(),
    ThemesPage(),
    RatingPage(),
  ];

  bool auth = false;

  @override
  init() async {}

  // / Use boot if you need to load data before the [view] is rendered.
  @override
  boot() async {
    dynamic lang = await NyStorage.read("com.srit.math.lang");
    dump(lang);
    if (lang != null) await changeLanguage(lang);
    auth = await Auth.loggedIn();
  }

  @override
  Widget view(BuildContext context) {
    !auth
        ? ApiService.authenticate().then((value) async {
            auth = await Auth.loggedIn();
            setState(() {});
          })
        : null;
    return (!auth && getEnv("AUTHORISATION"))
        ? Scaffold(
            appBar: AppBar(title: Text("login.page_name".tr())),
            body: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          ApiService.authenticate().then((value) async {
                            auth = await Auth.loggedIn();
                            setState(() {});
                          });
                        },
                        child: Text("general.auth".tr()))
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            body: _pages[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'profile.page_name'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'math.page_name'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.equalizer),
                  label: 'rating.page_name'.tr(),
                ),
              ],
            ),
          );
  }
}
