import 'package:flutter/material.dart';
import 'package:flutter_app/util/context_ext.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:nylo_framework/nylo_framework.dart';
import 'package:zoom_widget/zoom_widget.dart';

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
      appBar: AppBar(title: Text("info.page_name")),
      body: SafeArea(
        child: Zoom(
          canvasColor: context.theme.cardColor,
          backgroundColor: context.theme.cardColor,
          child: MarkdownBody(
              selectable: true,
              data: data,
              extensionSet: md.ExtensionSet(
                  md.ExtensionSet.gitHubFlavored.blockSyntaxes, [
                md.EmojiSyntax(),
                ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
              ])),
        ),
      ),
    );
  }
}
