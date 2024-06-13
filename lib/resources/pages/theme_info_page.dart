import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ThemeInfoPage extends NyStatefulWidget {
  static const path = '/info';

  ThemeInfoPage({super.key}) : super(path, child: _ThemeInfoPageState());
}

class _ThemeInfoPageState extends NyState<ThemeInfoPage> {
  @override
  init() async {}

  /// Use boot if you need to load data before the [view] is rendered.
  // @override
  // boot() async {
  //
  // }

  @override
  Widget view(BuildContext context) {
    var data = widget.data();
    return Scaffold(
      appBar: AppBar(title: Text(data["name"])),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Text(
              data["description"],
              textScaler: TextScaler.linear(2),
            ),
          ),
        ),
      ),
    );
  }
}
