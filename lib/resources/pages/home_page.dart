import 'package:flutter/material.dart';
import 'package:flutter_app/app/networking/api_service.dart';
import 'package:flutter_app/resources/pages/login_page.dart';
import 'package:flutter_app/resources/widgets/account_page_widget.dart';
import 'package:flutter_app/resources/widgets/rating_page_widget.dart';
import 'package:flutter_app/resources/widgets/themes_page_widget.dart';
import 'package:flutter_app/util/context_ext.dart';
import 'package:nylo_framework/nylo_framework.dart';

class HomePage extends NyStatefulWidget {
  static const path = '/home-page';

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_HomePagePageState>()?.restartApp();
  }

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
  init() async {
    auth = await Auth.loggedIn();
  }

  void restartApp() {
    routeToInitial();
    Auth.loggedIn().then((val) {
      setState(() {
        auth = val;
      });
    });
  }

  // / Use boot if you need to load data before the [view] is rendered.
  @override
  boot() async {
    dynamic lang = await NyStorage.read("com.srit.math.lang");
    dump(lang);
    if (lang != null)
      await changeLanguage(lang);
    else {
      changeLanguage("ru");
      await NyStorage.store("com.srit.math.lang", "ru");
    }
    auth = await Auth.loggedIn();
  }

  login(BuildContext context) {
    ApiService.authenticate().then((value) async {
      auth = await Auth.loggedIn();
      setState(() {});
    }).catchError((e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("error"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  context.nav.pop();
                },
                child: Text("general.ok".tr()),
              )
            ],
          );
        },
      );
    });
  }

  @override
  Widget view(BuildContext context) {
    Auth.loggedIn().then((val) {
      if (val != auth)
        setState(() {
          auth = val;
        });
    });
    dump(auth);
    !auth ? login(context) : null;
    if (!auth && getEnv("AUTHORISATION")) {
      return Scaffold(
        appBar: AppBar(title: Text("login.page_name".tr())),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      login(context);
                    },
                    child: Text("login.error".tr()))
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
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
}
