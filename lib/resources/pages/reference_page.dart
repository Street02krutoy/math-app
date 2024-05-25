import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ReferencePage extends NyStatefulWidget {
  static const path = '/reference';

  ReferencePage({super.key}) : super(path, child: _ReferencePageState());
}

class _ReferencePageState extends NyState<ReferencePage> {
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
      appBar: AppBar(title: Text("reference.page_name".tr())),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
