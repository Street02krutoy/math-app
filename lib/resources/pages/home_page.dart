import 'package:flutter/material.dart';
import 'package:flutter_app/resources/widgets/account_page_widget.dart';
import 'package:flutter_app/resources/widgets/custom_card_widget.dart';
import 'package:flutter_app/resources/widgets/rating_page_widget.dart';
import 'package:flutter_app/resources/widgets/themes_page_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

class HomePage extends NyStatefulWidget {
  static const path = '/home-page';

  HomePage({super.key}) : super(path, child: _HomePagePageState());
}

class _HomePagePageState extends NyState<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    AccountPage(),
    ThemesPage(),
    RatingPage(),
  ];

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
            label: 'profile_page'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'math_page'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            label: 'rating_page'.tr(),
          ),
        ],
      ),
    );
  }
}
