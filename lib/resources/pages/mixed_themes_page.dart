import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/solve_page.dart';
import 'package:flutter_app/util/context_ext.dart';
import 'package:nylo_framework/nylo_framework.dart';

class MixedThemesPage extends NyStatefulWidget {
  static const path = '/mixed';

  MixedThemesPage({super.key}) : super(path, child: _MixedThemesPageState());
}

class _MixedThemesPageState extends NyState<MixedThemesPage> {
  @override
  init() async {}

  /// Use boot if you need to load data before the [view] is rendered.
  @override
  boot() async {
    checkBoxes = List.generate(themeCount, (int index) => false);
  }

  List<bool>? checkBoxes;

  int get themeCount => 20;
  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("mixed.page_name".tr())),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    checkBoxes![index] = !checkBoxes![index];
                  });
                },
                child: Container(
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Column(
                        children: [Text("title"), Text("desc")],
                      ),
                      Spacer(),
                      Checkbox(
                          value: checkBoxes![index],
                          onChanged: (value) {
                            setState(() {
                              checkBoxes![index] = !checkBoxes![index];
                            });
                          })
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: context.theme.cardColor,
              );
            },
            itemCount: 20,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_forward_sharp),
          onPressed: () {
            routeTo(SolvePage.path);
          }),
    );
  }
}
