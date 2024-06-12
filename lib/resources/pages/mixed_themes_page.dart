import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/solve_page.dart';
import 'package:flutter_app/util/context_ext.dart';
import 'package:nylo_framework/nylo_framework.dart';
import "package:flutter_app/app/networking/api_service.dart";

class MixedThemesPage extends NyStatefulWidget {
  static const path = '/mixed';

  MixedThemesPage({super.key}) : super(path, child: _MixedThemesPageState());
}

class _MixedThemesPageState extends NyState<MixedThemesPage> {
  @override
  init() async {
    _data = widget.data();
    fetch();
  }

  /// Use boot if you need to load data before the [view] is rendered.
  @override
  boot() async {
    checkBoxes = List.generate(themeCount, (int index) => false);
  }

  List<bool>? checkBoxes;
  late Map _data;
  final ApiService apiService = ApiService();
  static Future? themes;

  fetch() {
    themes = apiService.getMixTopics();
  }

  int get themeCount => 20;

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("mixed.page_name".tr())),
      body: FutureBuilder(
        future: themes,
        builder: (context, snaphot) {
          if (snaphot.hasData) {
            List themeList = snaphot.data;
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  fetch();
                });
              },
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  checkBoxes![index] = !checkBoxes![index];
                                });
                              },
                              child: ListTile(
                                  title: Text(
                                    themeList[index]["name"],
                                  ),
                                  trailing: Checkbox(
                                      value: checkBoxes![index],
                                      onChanged: (value) {
                                        setState(() {
                                          checkBoxes![index] =
                                              !checkBoxes![index];
                                        });
                                      })),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              color: context.theme.cardColor,
                            );
                          },
                          itemCount: themeList.length,
                        ),
                      ),
                      Divider(
                        color: context.theme.cardColor,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              if (checkBoxes != null) {
                                if (checkBoxes!.any((e) => e)) {
                                  routeTo(
                                    SolvePage.path,
                                    data: {
                                      "complexity": _data["complexity"],
                                      "id": _data["id"],
                                      "placeholder": _data["placeholder"],
                                    },
                                  );
                                }
                              }
                            },
                            child: Icon(Icons.arrow_forward_sharp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(
            child: Column(
              children: [Spacer(), CircularProgressIndicator(), Spacer()],
            ),
          );
        },
      ),
    );
  }
}
