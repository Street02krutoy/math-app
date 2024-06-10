import 'package:flutter/material.dart';
import 'package:flutter_app/app/networking/api_service.dart';
import 'package:flutter_app/util/context_ext.dart';
import 'package:nylo_framework/nylo_framework.dart';

class TestPage extends NyStatefulWidget {
  static const path = '/test';

  TestPage({super.key}) : super(path, child: _TestPageState());
}

class _TestPageState extends NyState<TestPage> {
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
      appBar: AppBar(title: Text("Test")),
      body: SafeArea(
        child: TextButton(
          child: Text("user"),
          onPressed: () {
            ApiService(buildContext: context).getUser().then((value) {
              showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return AlertDialog(
                      title: Text("asd"),
                      content: value,
                      actions: [
                        TextButton(
                            onPressed: () {
                              context.nav.pop();
                            },
                            child: Text("Ok"))
                      ],
                    );
                  });
            });
          },
        ),
      ),
    );
  }
}
