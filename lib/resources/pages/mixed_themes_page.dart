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
  boot() async {}

  List checked = [];
  late Map _data;
  final ApiService apiService = ApiService();
  static Future? themes;

  fetch() {
    themes = apiService.getMixTopics();
  }

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
                                  if (checked.contains(index + 1)) {
                                    checked.remove(index + 1);
                                  } else {
                                    checked.add(index + 1);
                                  }
                                });
                              },
                              child: ListTile(
                                  title: Text(
                                    themeList[index]["name"],
                                  ),
                                  trailing: Checkbox(
                                      value: checked.contains(index + 1),
                                      onChanged: (value) {
                                        setState(() {
                                          if (checked.contains(index + 1)) {
                                            checked.remove(index + 1);
                                          } else {
                                            checked.add(index + 1);
                                          }
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
                              if (checked.isNotEmpty) {
                                routeTo(
                                  SolvePage.path,
                                  data: {
                                    "complexity": _data["complexity"],
                                    "id": _data["id"],
                                    "placeholder": _data["placeholder"],
                                    "topics": checked,
                                  },
                                );
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
