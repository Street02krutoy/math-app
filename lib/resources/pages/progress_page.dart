import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/app/networking/api_service.dart';
import 'package:flutter_app/resources/widgets/progress_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressPage extends NyStatefulWidget {
  static const path = '/progress';

  ProgressPage({super.key}) : super(path, child: _ProgressPageState());
}

class _ProgressPageState extends NyState<ProgressPage> {
  Future fetch() async {
    dump("s");
    _future = ApiService().getUserProgress();
  }

  @override
  init() async {
    _future == null ? fetch() : null;
  }

  static Future<dynamic>? _future;

  /// Use boot if you need to load data before the [view] is rendered.
  // @override
  // boot() async {
  //
  // }
  List<DoughnutData>? dataSource;

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("progress.page_name".tr())),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              fetch();
            });
            await _future;
          },
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                dataSource = List.generate(snapshot.data!.length, (int index) {
                  return DoughnutData(
                      name: snapshot.data[index]["name"],
                      count: snapshot.data[index]["solved_tasks"]);
                });
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        child: SfCircularChart(
                          legend: Legend(isVisible: true),
                          series: [
                            DoughnutSeries<DoughnutData, String>(
                              //explode: true,

                              dataSource: dataSource,
                              xValueMapper: (datum, int index) =>
                                  "${datum.name} - ${datum.count}",
                              yValueMapper: (datum, int index) => datum.count,
                              //dataLabelSettings: DataLabelSettings(isVisible: true)
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: List<Widget>.generate(10, (int index) {
                          return ProgressWidget(
                              title: snapshot.data[index]["name"],
                              done: snapshot.data[index]["solved_tasks"]);
                        }),
                      )
                    ],
                  ),
                );
              }
              return Center(
                child: Column(
                  children: [Spacer(), CircularProgressIndicator(), Spacer()],
                ),
              );
            },
            future: _future,
          ),
        ),
      ),
    );
  }
}

class DoughnutData {
  DoughnutData({required this.name, required this.count});
  final String name;
  final int count;
}
