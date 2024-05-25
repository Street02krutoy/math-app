import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProgressPage extends NyStatefulWidget {
  static const path = '/progress';

  ProgressPage({super.key}) : super(path, child: _ProgressPageState());
}

class _ProgressPageState extends NyState<ProgressPage> {
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
      appBar: AppBar(title: Text("progress.page_name".tr())),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
