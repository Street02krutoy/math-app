import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

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
      appBar: AppBar(title: Text("settings.page_name".tr())),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
